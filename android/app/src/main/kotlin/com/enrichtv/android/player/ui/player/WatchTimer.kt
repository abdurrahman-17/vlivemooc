package com.enrichtv.android.ui.player

import com.google.android.exoplayer2.Player
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import java.util.concurrent.TimeUnit

/**
 * Clock Implementation to calculate the total watch duration in real time of the content.
 *
 * @author Mohan
 */
class WatchTimer {

    private var realTimeInMs: Long = 0L
    private var isInitialized: Boolean = false
    private var startTimeInMs: Long = 0L

    /**
     * Computes & Returns the total elapsed time after initialize() function called.
     *
     * @return Total seconds in Seconds.
     */
    fun compute() {
        if (!isInitialized) return
//        val currentElapsedTime = SystemClock.elapsedRealtime()
        val currentElapsedTime = System.currentTimeMillis()
        realTimeInMs += currentElapsedTime - startTimeInMs
//        startTimeInMs = SystemClock.elapsedRealtime()
        startTimeInMs = System.currentTimeMillis()
    }

    /**
     * Returns the total elapsed time after initialize() function called.
     *
     * @return Total seconds
     */
    fun getWatchTime(): Long = TimeUnit.MILLISECONDS.toSeconds(realTimeInMs)

    /**
     * Initialize the current time elapsed.
     *
     * Call this event during the player playback state [Player.STATE_READY] and the playback started playing.
     */
    fun init() {
        isInitialized = true
        startTimeInMs = System.currentTimeMillis()
    }

    /**
     * Function to be called when the Player state is pause.
     */
    fun pause() {
        isInitialized = false
    }

    /**
     * Reset the clock to the init state.
     */
    fun reset() {
        isInitialized = false
        realTimeInMs = 0L
    }

    fun getCurrentTimeFormatted(): String {
        val currentTime = Calendar.getInstance().time
        val dateFormat = SimpleDateFormat("MMMM d, yyyy HH:mm:ss", Locale.getDefault())
        return dateFormat.format(currentTime)
    }
}

