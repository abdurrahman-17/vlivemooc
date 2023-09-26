package com.enrichtv.android.util

import android.os.Handler
import com.enrichtv.android.player.Constants.LONG_ZERO

/**
 * @author Shaik Mohammed Ghouse
 * @since 25/5/21
 **/

object FingerPrintHandler : Runnable {

    private var mListener: (() -> Unit)? = null

    fun invokeOverlay(listener: () -> Unit) {
        mListener = listener
    }

    private val handler: Handler = Handler()

    /**
     * Starts the Handler
     */
    fun start() {
        handler.postDelayed(this, LONG_ZERO)
    }

    /**
     * Cancels the handler
     */
    fun cancel() {
        handler.removeCallbacks(this)
    }

    override fun run() {
        mListener?.invoke()
        start()
    }

}
