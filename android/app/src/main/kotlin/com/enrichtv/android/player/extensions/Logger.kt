package com.enrichtv.android.extensions

import android.util.Log

/**
 * Use this class to print all the log in the application. Logs are displayed only for the Debug
 * mode.<br></br>
 * Usage:<br></br>
 * ------------<br></br>
 *
 *
 * Logger.tag("TAG").v("MESSAGE");
 *
 *
 * Logger.tag("TAG").d("MESSAGE");
 *
 *
 * Logger.tag("TAG").i("MESSAGE");
 *
 *
 * Logger.tag("TAG").w("MESSAGE");
 *
 *
 * Logger.tag("TAG").e("MESSAGE");
 */
class Logger private constructor(private val tag: String) {

    /**
     * Prints message in verbose
     *
     * @param message Message to be printed
     */
    fun v(message: String?) {
        message?.run { Log.v(tag, message) }
    }

    /**
     * Prints message in debug
     *
     * @param message Message to be printed
     */
    fun d(message: String?) {
        message?.run { Log.d(tag, message) }
    }

    /**
     * Prints message in info
     *
     * @param message Message to be printed
     */
    fun i(message: String?) {
        message?.run { Log.i(tag, message) }
    }

    /**
     * Prints message in warning
     *
     * @param message Message to be printed
     */
    fun w(message: String?) {
        message?.run { Log.w(tag, message) }
    }

    /**
     * Prints message in error
     *
     * @param message Message to be printed
     */
    fun e(message: String?) {
        message?.run { Log.e(tag, message) }
    }

    companion object {

        /**
         * Returns new Logger instance with specified tag.
         *
         * @param tag Tag to be displayed
         */
        @JvmStatic
        fun tag(tag: String): Logger {
            return Logger(tag)
        }
    }
}

