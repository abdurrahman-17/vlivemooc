/**
 * Common Extension method for vLIve
 * */
package com.enrichtv.android.util

import android.animation.ObjectAnimator
import android.annotation.SuppressLint
import android.app.ActivityManager
import android.app.Dialog
import android.content.ContentResolver
import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import android.net.Uri
import android.telephony.TelephonyManager
import android.view.View
import android.view.animation.AnimationUtils
import android.view.animation.OvershootInterpolator
import android.widget.CheckedTextView
import android.widget.ImageView
import androidx.annotation.AnyRes
import androidx.annotation.ColorRes
import androidx.annotation.StringRes
import androidx.appcompat.widget.AppCompatTextView
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.fragment.app.FragmentActivity
import com.enrichtv.android.player.models.content.Content
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.enrichtv.android.R

import com.google.android.exoplayer2.offline.Download
import com.google.android.exoplayer2.util.Util
import com.google.gson.GsonBuilder
import com.mobiotics.api.deserializer.DateDeserializer
import com.mobiotics.core.extensions.fromJson
import com.mobiotics.player.exo.PlayerComponent
import com.mobiotics.player.exo.download.DownloadTracker
import com.mobiotics.player.exo.offline.Offline
import com.enrichtv.android.player.Constants
import com.enrichtv.android.player.Constants.FLOAT_POINT_FIVE
import com.enrichtv.android.player.Constants.HUNDRER

import java.util.*
import kotlin.reflect.KClass
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


/**
 * @author Ashik
 * Created on 6/2/20 .
 */

/**
 * Show view with/without animation
 * @param hasAnimate if(true) Fade animation for the view
 * @param objectAnimate if(true) animation with value animator class
 *
 * @author Ashik
 * @since 6/2/20 .
 * */

fun View?.show(hasAnimate: Boolean = false, objectAnimate: Boolean = false) {
    this ?: return
    if (!this.isVisible) {
        if (hasAnimate) this.startAnimation(
            AnimationUtils.loadAnimation(
                this.context,
                R.anim.fragment_fade_enter
            )
        )
        else if (objectAnimate) {
            ObjectAnimator.ofPropertyValuesHolder(
                this,
                PropertyValueHolder.Show.scaleX,
                PropertyValueHolder.Show.scaleY,
                PropertyValueHolder.Show.alpha
            )
                .apply { interpolator = OvershootInterpolator() }.start()
        }
        this.visibility = View.VISIBLE
    }
}

/**
 * Hide view with/without animation
 * @param hasAnimate if(true) fade animation for the view
 * @author Ashik
 * @since 6/2/20 .
 * */
fun View?.hide(hasAnimate: Boolean = false, objectAnimate: Boolean = false) {
    this ?: return
    if (this.isVisible) {
        if (hasAnimate) this.startAnimation(
            AnimationUtils.loadAnimation(
                this.context,
                R.anim.fragment_fade_exit
            )
        )
        else if (objectAnimate) {
            ObjectAnimator.ofPropertyValuesHolder(
                this,
                PropertyValueHolder.Hide.scaleX,
                PropertyValueHolder.Hide.scaleY,
                PropertyValueHolder.Hide.alpha
            )
                .apply { interpolator = OvershootInterpolator() }.start()
        }
        this.visibility = View.GONE
    }
}

/**
 * Hide view with/without animatio
 * @param hasAnimate if(true) fade animation will happen
 * @author Ashik
 * Created on 15/05/20 .
 * */
fun View?.inVisible(hasAnimate: Boolean = false) {
    this ?: return
    if (this.isVisible) {
        if (hasAnimate) this.startAnimation(
            AnimationUtils.loadAnimation(
                this.context,
                R.anim.fragment_fade_exit
            )
        )
        this.visibility = View.INVISIBLE
    }
}

/**
 * Make view Disable
 *
 * @author Ashik
 * @since 12/05/2020.
 * */
fun View?.disable() {
    this ?: return
    this.apply {
        isEnabled = false
        isClickable = false
        alpha = FLOAT_POINT_FIVE
    }
}

/**
 * Disable views
 * @param views
 * @author Ashik
 * @since 01/06/2020
 * */
fun disableViews(vararg views: View?) {
    views.forEach {
        it.disable()
        it?.alpha = FLOAT_POINT_FIVE
    }
}

/**
 * Enable views
 *  @param views
 * @author Ashik
 * @since 01/06/2020
 * */
fun enableViews(vararg views: View?) {
    views.forEach {
        it?.alpha = Constants.FLOAT_ONE_POINT_ZERO
        it.enable()
    }
}

/**
 * @author Ashik
 * Created on 12/05/2020.
 *
 * Make View Enable
 * */
fun View?.enable() {
    this ?: return
    this.apply {
        isEnabled = true
        alpha = 1.0F
        isClickable = true
    }
}

/**
 * Returns the string based on the [stringRes]
 *
 * @param stringRes
 */
fun Context.resString(@StringRes stringRes: Int) = this.resources.getString(stringRes)

/**
 * Returns the string based on the [stringRes] & the [formatArgs]
 *
 * @param stringRes
 * @param formatArgs
 */
fun Context.resString(@StringRes stringRes: Int, vararg formatArgs: Any?) =
    this.resources.getString(stringRes, formatArgs)

/**
 * Determine whether you have Wifi/not
 * @param downloadViaWifi
 *
 * @author Ashik
 * @since 12/05/2020.
 * */
@Suppress("TooGenericExceptionCaught", "TooGenericExceptionThrown")
fun Context?.checkWifiSettings(downloadViaWifi: Boolean): Boolean {
    this ?: throw RuntimeException()
    if (!downloadViaWifi) return true
    if (downloadViaWifi && !ConnectionHelper(this).isWifi()) throw RuntimeException(
        this.resources.getString(
            R.string.download_via_error
        )
    )
    return true
}

/**
 * Method for update check state with Delay
 *
 * @author Ashik
 * @since 01/06/2020
 * */
fun CheckedTextView?.checkWithDelay() {
    this ?: return
    CoroutineScope(Dispatchers.Main).launch {
        delay(HUNDRER.toLong())
        this@checkWithDelay.isChecked = !this@checkWithDelay.isChecked
    }
}

/**
 * Method will use to set tint color to imageView
 *
 * @author Ratnesh Kumar Ratan
 * @since 02/08/2020
 **/
fun ImageView.tintColor(@ColorRes colorRes: Int) {
    this.setColorFilter(
        ContextCompat.getColor(context, colorRes),
        android.graphics.PorterDuff.Mode.SRC_IN
    )
}

/**
 * Check the item can Play
 * only STATE_COMPLETED content can play
 * @author Ashik
 * @since 25/06/2020
 * */
fun Offline.canPlayItem() = this.downloadState == Download.STATE_COMPLETED

/**
 * Check this clicked item can delete/not
 * only STATE_COMPLETED | STATE_FAILED | STATE_STOPPED content can delete
 * @author Ashik
 * @since 25/06/2020
 * */
fun Offline.canDeleteItem() =
    this.downloadState == Download.STATE_COMPLETED || this.downloadState == Download.STATE_FAILED
            || (this.downloadState == Download.STATE_STOPPED
            && this.stopReason != DownloadTracker.PAUSE_REASON)

/**
 * Return [Content]  from Offline object
 * */
fun Offline.content() = this.contentData?.let { Util.fromUtf8Bytes(it) }?.let {
    GsonBuilder().registerTypeAdapter(Date::class.java, DateDeserializer()).create()
        .fromJson<Content>(it)
}

/**
 * Return license is expired or not
 * */
fun Offline.licenseExpiry(): Boolean {
    return PlayerComponent.getInstance().isOfflineLicenseKeyExpired(this._id)
}

/**
 * Returns the country code of the current device location.
 *
 * @return null if the country code is not available.
 */
@SuppressLint("MissingPermission")
fun Context?.getCountryCode(): String? {
    if (this == null) return null
//    val locationManager = ContextCompat.getSystemService(this, LocationManager::class.java)
//    val location = locationManager?.getLastKnownLocation(LocationManager.PASSIVE_PROVIDER)
    var countryCode: String? = null
//    if (location != null) {
//        countryCode = try {
//            val geoCoder = Geocoder(this)
//            val addresses = geoCoder.getFromLocation(location.latitude, location.longitude, 1)
//            addresses[0].countryCode
//        } catch (e: Exception) {
//            null
//        }
//    }
    if (countryCode == null) {
        val tm = ContextCompat.getSystemService(this, TelephonyManager::class.java)
        countryCode = tm?.networkCountryIso?.toUpperCase(Locale.ENGLISH)
    }
    return countryCode
}

/**
 * Make kids view
 *
 * @author Ratnesh Kumar Ratan
 * @since 29/12/2021
 **/
fun AppCompatTextView?.makeKidsView() {
    this ?: return
    this?.text = this.context.getString(R.string.kids)
    this.background = ContextCompat.getDrawable(this.context, R.drawable.button_background)
    this.show()
}


/**
 * Make admin view
 *
 * @author Ratnesh Kumar Ratan
 * @since 29/12/2021
 **/
fun AppCompatTextView?.makeAdminView() {
    this ?: return
    this?.text = this.context.getString(R.string.admin)
    this.background = ContextCompat.getDrawable(this.context, R.drawable.button_background)
    this.show()
}

/**
 * Make admin Image
 *
 * @author Shaik Mohammed Ghouse
 * @since 22/08/2022
 **/
fun AppCompatTextView?.makeAdminImage() {
    this ?: return
    this?.text = Constants.EMPTY_STRING
    this.background = ContextCompat.getDrawable(this.context, R.drawable.bg_admin_tag)
    this.show()
}



/**
 * Applies Blur dialog background from the Activity.
 *
 * @param activity Current activity instance
 * @author Mohan
 * @since 14 Aug 2020
 */
fun Dialog?.applyBlurDialogBackground(activity: FragmentActivity) {
    if (this == null) return
    val view: View = activity.window.decorView
    val originalBitmap = getBitmapFromView(view) ?: return

    fun updateBackgroundDrawable(drawable: Drawable) {
        this.window?.setBackgroundDrawable(drawable)
    }
    GlideApp.with(context).load(originalBitmap)/*.blur(context)*/
        .into(object : CustomTarget<Drawable>() {
            override fun onLoadCleared(placeholder: Drawable?) {
                // do nothing
            }

            override fun onResourceReady(resource: Drawable, transition: Transition<in Drawable>?) {
                updateBackgroundDrawable(resource)
            }
        })
}

/**
 * Take screen shot of the view passed & returns the bitmap image.
 *
 * @param view View to take screenshot
 * @return [Bitmap]
 * @author Mohan
 * @since 14 Aug 2020
 */
@Suppress("TooGenericExceptionCaught")
private fun getBitmapFromView(view: View): Bitmap? {
    return try {
        val bitmap = Bitmap.createBitmap(view.width, view.height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        view.draw(canvas)
        canvas.drawColor(ContextCompat.getColor(view.context, R.color.c_p_dialog_overlay))
        bitmap
    } catch (e: Exception) {
        null
    }
}

/**
 * Returns the resource in Uri format
 *
 * @param resId Resource id.
 * @return
 */
fun Context.resourceToUri(@AnyRes resId: Int): Uri {
    return Uri.parse(
        "${ContentResolver.SCHEME_ANDROID_RESOURCE}://${resources.getResourcePackageName(resId)}/${
            resources.getResourceTypeName(resId)
        }/${resources.getResourceEntryName(resId)}"
    )
}

/**
 * Returns whether the service is running or not.
 *
 * @param serviceClass Service class
 * @return true if the service is already running; false otherwise.
 */
@Suppress("DEPRECATION")
fun Context.isServiceRunning(serviceClass: KClass<*>): Boolean {
    val activityManager = ContextCompat.getSystemService(this, ActivityManager::class.java)

    return activityManager?.getRunningServices(Integer.MAX_VALUE)
        ?.any { it.service.className == serviceClass.java.name } ?: false
}
