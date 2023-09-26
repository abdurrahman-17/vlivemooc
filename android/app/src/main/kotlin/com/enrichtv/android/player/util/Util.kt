package com.enrichtv.android.util

import android.annotation.TargetApi
import android.content.Context
import android.graphics.Point
import android.os.Build
import android.util.DisplayMetrics
import android.view.Display
import androidx.fragment.app.FragmentActivity
import com.google.android.exoplayer2.util.Util
import com.enrichtv.android.player.Constants
import com.enrichtv.android.player.Constants.ZERO
import java.util.Calendar
import java.util.TimeZone

/**
 * Get device width
 *
 * @author Ashik
 * @since 7/2/2020
 **/
fun Context?.getDeviceWidth(): Int {
    this ?: return ZERO
    val displayMetrics: DisplayMetrics = this.resources.displayMetrics
    return displayMetrics.widthPixels
}
fun currentUTCTime(): Long {
    return Calendar.getInstance(TimeZone.getTimeZone("UTC")).timeInMillis / 1000
}

/**
 * Get window height
 *
 * @author Ashik
 * @since 7/2/2020
 **/
fun Context?.getDeviceHeight(): Int {
    this ?: return ZERO
    val displayMetrics: DisplayMetrics = this.resources.displayMetrics
    return displayMetrics.heightPixels
}

/**
 * returns seconds to milliseconds
 *
 **/
fun Int.toMs(): Long {
    return this * Constants.TIME_DELAY_ONE_MIN
}
fun List<String>?.checkCTMusicTag(): Boolean {
    var checkFlag: Boolean = false
    if (this.isNullOrEmpty()) return false
    this.forEach {
        if (it.uppercase() == "CT-MUSIC") checkFlag = true
    }
    return checkFlag
}

fun List<String>?.checkCTShortsTag(): Boolean {
    var checkFlag: Boolean = false
    if (this.isNullOrEmpty()) return false
    this.forEach {
        if (it.uppercase() == "CT-SHORTS" || it.uppercase() == "CT-KIDS") checkFlag = true
    }
    return checkFlag
}
private const val WIDTH_4K = 3840
private const val HEIGHT_4K = 2160

/**
 * Check is screen supports 4K video
 * @return true or false
 *
 * @author Ashik
 * @since 28/9/2020
 **/
fun FragmentActivity?.is4K(): Boolean {    //4K
    val display: Display? = this?.windowManager?.defaultDisplay
    display?.let {
        val displaySize: Point = getDisplaySize(it)
        return displaySize.x >= WIDTH_4K && displaySize.y >= HEIGHT_4K
    }
    return false
}

@Throws(NoSuchElementException::class)
private fun getDisplaySize(display: Display): Point {
    val displaySize = Point()
    if (Util.SDK_INT >= Build.VERSION_CODES.M) {
        getDisplaySizeV23(display, displaySize)
    } else
        getDisplaySizeV17(display, displaySize)
    return displaySize
}

@TargetApi(Build.VERSION_CODES.M)
@Throws(NoSuchElementException::class)
private fun getDisplaySizeV23(display: Display, outSize: Point) {
    val modes = display.supportedModes
    if (modes.isNotEmpty()) {
        val mode = modes.first()
        outSize.x = mode.physicalWidth
        outSize.y = mode.physicalHeight
    }
}

@TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
private fun getDisplaySizeV17(display: Display, outSize: Point) {
    display.getRealSize(outSize)
}

private const val WIDTH_HD = 720
private const val HEIGHT_HD = 480

/**
 * Check is screen supports HD video
 * @return true or false
 *
 * @author Ashik
 * @since 28/9/2020
 **/
fun FragmentActivity?.isHd(): Boolean {      //HD
    val display: Display? = this?.windowManager?.defaultDisplay
    display?.let {
        val displaySize: Point = getDisplaySize(it)
        return displaySize.x >= WIDTH_HD && displaySize.y >= HEIGHT_HD
    }
    return false
}
