/**
 * This class will use to register local broadcast for network state change,
 **/
package com.enrichtv.android.util

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.content.getSystemService
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.mobiotics.core.extensions.isOnline

/**
 * @author Mohan
 * @since 17/03/2020
 **/
class ConnectionHelper(private val context: Context) {

    private var cm: ConnectivityManager? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        context.getSystemService(ConnectivityManager::class.java)
    } else {
        context.getSystemService()
    }
    private val connectivityReceiver = ConnectivityReceiver()
    private var listener: ((isConnectionAvailable: Boolean) -> Unit)? = null

    private val networkCallback = @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) {
            listener?.invoke(true)
        }

        override fun onLost(network: Network) {
            listener?.invoke(false)
        }
    }

    /**
     * TODO
     *
     * @param listener
     */
    fun setConnectionListener(listener: (isConnectionAvailable: Boolean) -> Unit) {
        this.listener = listener
    }

    /**
     * To register local broadcast for network status change
     *
     * @modified Ratnesh Kumar Ratan
     * @since 20/04/2020
     **/
    fun registerCallback() {

        when {
            AndroidApiConst.IS_NOUGAT_AND_ABOVE -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                cm?.registerDefaultNetworkCallback(
                    networkCallback
                )
            }
            AndroidApiConst.IS_LOLLIPOP_AND_ABOVE -> cm?.registerNetworkCallback(
                NetworkRequest.Builder().build(),
                networkCallback
            )
            else -> {
                listener?.invoke(context.isOnline())
                LocalBroadcastManager.getInstance(context)
                    .registerReceiver(
                        connectivityReceiver,
                        IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION)
                    )
            }
        }
    }

    /**
     * Un-register the callback once not in use.
     */
    fun unregisterCallback() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            // cm?.unregisterNetworkCallback(networkCallback)
        } else
            LocalBroadcastManager.getInstance(context).unregisterReceiver(connectivityReceiver)
    }

    private inner class ConnectivityReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            listener?.invoke(context.isOnline())
        }
    }

    /**
     * Determine whether you have Wifi/not
     *
     * @author Ashik
     * @since 12/05/2020
     * */
    @Suppress("DEPRECATION")
    fun isWifi(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val activeNetwork = cm?.activeNetwork
            val capabilities = cm?.getNetworkCapabilities(activeNetwork)
            capabilities != null && capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)
        } else {
            cm?.activeNetworkInfo?.type == ConnectivityManager.TYPE_WIFI
        }
    }
}
