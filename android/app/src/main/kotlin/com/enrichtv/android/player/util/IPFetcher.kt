package com.enrichtv.android.player.util

import android.os.Handler
import android.os.Looper
import android.util.Log
import java.net.Inet4Address
import java.net.InetAddress
import java.net.NetworkInterface
import java.net.SocketException

class IPFetcher(private val intervalMillis: Long, private val listener: IPListener) {
    private val handler = Handler(Looper.getMainLooper())
    private var isRunning = false

    private val fetchRunnable = object : Runnable {
        override fun run() {
            if (isRunning) {
                val ipAddress = getIPAddress()
                listener.onIPFetched(ipAddress)
                handler.postDelayed(this, intervalMillis)
            }
        }
    }

    interface IPListener {
        fun onIPFetched(ipAddress: String?)
    }

    fun startFetching() {
        if (!isRunning) {
            isRunning = true
            handler.post(fetchRunnable)
        }
    }

    fun stopFetching() {
        if (isRunning) {
            isRunning = false
            handler.removeCallbacks(fetchRunnable)
        }
    }


    fun getIPAddress(): String? {
        try {
            val interfaces = NetworkInterface.getNetworkInterfaces()
            while (interfaces.hasMoreElements()) {
                val networkInterface = interfaces.nextElement()
                val addresses = networkInterface.inetAddresses
                while (addresses.hasMoreElements()) {
                    val address = addresses.nextElement()
                    if (!address.isLoopbackAddress && address is Inet4Address) {
                        //Log.e("TAG", "getIPAddress: "+address.hostAddress )
                        return address.hostAddress
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return ""
    }


}
