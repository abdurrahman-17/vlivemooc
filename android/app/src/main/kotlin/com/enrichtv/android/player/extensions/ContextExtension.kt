package com.enrichtv.android.extensions

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.app.ActivityManager
import android.app.UiModeManager
import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.res.Configuration
import android.content.res.Resources
import android.graphics.drawable.Drawable
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.NetworkInfo
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.DisplayMetrics
import android.view.View
import android.view.inputmethod.InputMethodManager
import androidx.annotation.AnyRes
import androidx.annotation.ColorRes
import androidx.annotation.DimenRes
import androidx.annotation.DrawableRes
import androidx.annotation.RequiresPermission
import androidx.annotation.StringRes
import androidx.core.content.ContextCompat

import java.lang.ref.WeakReference
import kotlin.math.roundToInt
import kotlin.reflect.KClass

/**
 * Shows Toast message
 *
 * @param message Message to display
 */
fun Context?.toast(@StringRes message: Int) {
    if (this == null) return
    ToastUtil.toast(this, message)
}

/**
 * Shows Toast message
 *
 * @param message Message to display
 */
fun Context?.toast(message: String) {
    if (this == null) return
    ToastUtil.toast(this, message)
}

/**
 * Returns the [ConnectivityManager] instance.
 *
 * @return [ConnectivityManager] instance
 */
internal fun Context?.connectivityManager(): ConnectivityManager? {
    if (this == null) return null
    return ContextCompat.getSystemService(this, ConnectivityManager::class.java)
}


/**
 * Checks whether device is connected to network or not
 * @return true-> if connected, false-> if not connected
 */
@RequiresPermission(value = Manifest.permission.ACCESS_NETWORK_STATE)
@Suppress("DEPRECATION")
fun Context?.isOnline(): Boolean {
    this?.run {
        val netWorkInfo: NetworkInfo? = connectivityManager()?.activeNetworkInfo
        return netWorkInfo != null && netWorkInfo.isConnected
    }
    return false
}

/**
 * Checks whether the mobile is connected to Wi-Fi or not
 */
@RequiresPermission(value = Manifest.permission.ACCESS_NETWORK_STATE)
fun Context?.isConnectedToWifiNetwork(): Boolean {
    this?.run {
        val cm = connectivityManager()
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val activeNetwork = cm?.activeNetwork
            val capabilities = cm?.getNetworkCapabilities(activeNetwork)
            capabilities != null && capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)
        } else {
            cm?.activeNetworkInfo?.type == ConnectivityManager.TYPE_WIFI
        }
    }
    return false
}

/**
 * Checks whether the mobile is connected to Mobile-data or not
 *
 */
@RequiresPermission(value = Manifest.permission.ACCESS_NETWORK_STATE)
fun Context?.isConnectedToCellularNetwork(): Boolean {
    this?.run {
        val cm = connectivityManager()
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val activeNetwork = cm?.activeNetwork
            val capabilities = cm?.getNetworkCapabilities(activeNetwork)
            capabilities != null && capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR)
        } else {
            cm?.activeNetworkInfo?.type == ConnectivityManager.TYPE_MOBILE
        }
    }
    return false
}

/**
 *  Hides the keyboard from the user
 * @param view
 */
fun Context?.hideKeyboard(view: View) {
    val imm = this?.getSystemService(Context.INPUT_METHOD_SERVICE) as? InputMethodManager
    imm?.hideSoftInputFromWindow(view.windowToken, 0)
}

/**
 * Displays the keyboard to the user
 * @param view
 */
fun Context?.showKeyboard(view: View) {
    val imm = this?.getSystemService(Context.INPUT_METHOD_SERVICE) as? InputMethodManager
    imm?.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT)
}

/**
 * Returns whether the current device is Tablet or not
 */
fun Context?.isTablet(): Boolean {
    if (this == null) return false
    return resources.configuration.screenLayout and Configuration.SCREENLAYOUT_SIZE_MASK >=
            Configuration.SCREENLAYOUT_SIZE_LARGE
}

/**
 * Returns whether the current device is Mobile or not
 */
fun Context?.isMobile(): Boolean {
    if (this == null) return false
    return resources.configuration.screenLayout and Configuration.SCREENLAYOUT_SIZE_MASK <=
            Configuration.SCREENLAYOUT_SIZE_NORMAL
}

/**
 * Returns whether the Device System is TV or not
 *
 * @return true if TV device; false otherwise.
 */
fun Context?.isAndroidTV(): Boolean {
    this ?: return false
    val uiModeManager = ContextCompat.getSystemService(this, UiModeManager::class.java)
    return uiModeManager?.currentModeType == Configuration.UI_MODE_TYPE_TELEVISION ||
            packageManager.hasSystemFeature("android.hardware.type.television")
}

/**
 * Returns the unique device ID of the Android Mobile
 */
@SuppressLint("HardwareIds")
fun Context?.getDeviceId(): String {
    return Settings.Secure.getString(this?.contentResolver, Settings.Secure.ANDROID_ID)
}

/**
 * Returns the App user-agent which can be used to pass in the API headers or params.
 * @param appName Application name
 */
fun Context?.getAppUserAgent(appName: String): String {
    if (this == null) return ""
    val versionName = try {
        val packageName = packageName
        val info = packageManager.getPackageInfo(packageName, 0)
        info.versionName
    } catch (ignore: PackageManager.NameNotFoundException) {
        "?"
    }
    return "$appName/$versionName (${Build.MANUFACTURER} ${Build.MODEL};Android ${Build.VERSION.RELEASE})"
}

/**
 * Opens the App in play store.
 */
fun Context?.openAppInPlayStore() {
    if (this == null) return
    try {
        startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$packageName")))
    } catch (ignore: android.content.ActivityNotFoundException) {
        startActivity(
            Intent(
                Intent.ACTION_VIEW,
                Uri.parse("https://play.google.com/store/apps/details?id=$packageName")
            )
        )
    }
}


/**
 * Returns the app version code
 */
fun Context?.getAppVersionCode(): Long? {
    if (this == null) return 0L
    return try {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            packageManager.getPackageInfo(packageName, 0).longVersionCode
        } else {
            packageManager.getPackageInfo(packageName, 0).versionCode.toLong()
        }
    } catch (ignore: Exception) {
        0L
    }
}

/**
 * Returns the app version name
 */
fun Context?.getAppVersionName(): String {
    if (this == null) return ""
    return packageManager.getPackageInfo(packageName, 0).versionName
}

/**
 * Converts Dp to Pixel
 */
fun Context?.dpToPx(dp: Int): Int {
    if (this == null) return 0
    val density = resources.displayMetrics.density
    return (dp.toFloat() * density).roundToInt()
}


/**
 * Launches activity.
 * @param options [Bundle]
 * @param init set addition flags or data to extras to the intent object
 */
inline fun <reified T : Any> Activity?.launchActivity(
    options: Bundle? = null,
    noinline init: Intent.() -> Unit = {}
) {
    if (this != null) {
        val intent = newIntent<T>()
        if (intent != null) {
            intent.init()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                startActivity(intent, options)
            } else {
                startActivity(intent)
            }
        }
    }
}


/**
 * Launches activity.
 * @param requestCode Request Code.
 * @param options [Bundle]
 * @param init set addition flags or data to extras to the intent object
 */
inline fun <reified T : Any> Activity?.launchActivityForResult(
    requestCode: Int = -1,
    options: Bundle? = null,
    noinline init: Intent.() -> Unit = {}
) {
    if (this != null) {
        val intent = newIntent<T>()
        if (intent != null) {
            intent.init()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                startActivityForResult(intent, requestCode, options)
            } else {
                startActivityForResult(intent, requestCode)
            }
        }
    }
}


/** Launches activity.
 * @param options [Bundle]
 * @param init set addition flags or data to extras to the intent object
 * */
inline fun <reified T : Any> Context?.launchActivity(
    options: Bundle? = null,
    noinline init: Intent.() -> Unit = {}
) {
    if (this != null) {
        val intent = newIntent<T>()
        if (intent != null) {
            intent.init()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                startActivity(intent, options)
            } else {
                startActivity(intent)
            }
        }
    }
}

/**
 * Creates new Intent Object
 */
inline fun <reified T : Any> Context?.newIntent(): Intent? {
    return if (this == null) null else Intent(this, T::class.java)
}

/**
 * Parses the meta-data provided in the AndroidManifest file
 *
 * @param key Key in which the value is required.
 * @return Nullable String representation of the value.
 */
fun Context?.getMetaDataValue(key: String): String? {
    this?.run {
        try {
            val ai = packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
            val bundle = ai.metaData
            return bundle.getString(key)
        } catch (ignore: PackageManager.NameNotFoundException) {
            Logger.tag("Meta-Data").e(ignore.message)
        } catch (ignore: NullPointerException) {
            Logger.tag("Meta-Data").e(ignore.message)
        }
    }
    return null
}

/**
 * Retrieve a dimensional for a particular resource ID.  Unit
 * conversions are based on the current {@link DisplayMetrics} associated
 * with the resources.
 *
 * @param dimenRes The desired resource identifier, as generated by the aapt
 *           tool. This integer encodes the package, type, and resource
 *           entry. The value 0 is an invalid identifier.
 * @return Resource dimension value multiplied by the appropriate metric to convert to pixels.
 * @throws Resources.NotFoundException Throws NotFoundException if the given ID does not exist.
 */
@Throws(Resources.NotFoundException::class)
fun Context?.getDimension(@DimenRes dimenRes: Int): Float {
    if (this == null) return 0F
    return resources.getDimension(dimenRes)
}

/**
 * Retrieve a dimensional for a particular resource ID for use as a size in raw pixels.
 * This is the same as getDimension(int), except the returned value is converted to integer
 * pixels for use as a size. A size conversion involves rounding the base value, and ensuring
 * that a non-zero base value is at least one pixel in size.
 *
 * @param dimenRes The desired resource identifier, as generated by the aapt tool. This integer encodes the
 * package, type, and resource entry. The value 0 is an invalid identifier
 * @return Resource dimension value multiplied by the appropriate metric and truncated to integer pixels
 * @throws Resources.NotFoundException Throws NotFoundException if the given ID does not exist.
 */
@Throws(Resources.NotFoundException::class)
fun Context?.getDimensionInPixelSize(@DimenRes dimenRes: Int): Int {
    if (this == null) return 0
    return resources.getDimensionPixelSize(dimenRes)
}

/**
 * Retrieve a dimensional for a particular resource ID for use as a size in raw pixels.
 * This is the same as getDimension(int), except the returned value is converted to integer
 * pixels for use as a size. A size conversion involves rounding the base value, and ensuring
 * that a non-zero base value is at least one pixel in size
 *
 * @param dimenRes The desired resource identifier, as generated by the aapt tool. This integer encodes
 * the package, type, and resource entry. The value 0 is an invalid identifier.
 * @return Resource dimension value multiplied by the appropriate metric and truncated to integer pixels
 * @throws Resources.NotFoundException Throws NotFoundException if the given ID does not exist.
 */
@Throws(Resources.NotFoundException::class)
fun Context?.getDimensionInPixelOffset(@DimenRes dimenRes: Int): Int {
    if (this == null) return 0
    return resources.getDimensionPixelOffset(dimenRes)
}


/**
 * Checks whether all the permissions passed have permission granted.
 *
 * @param permissions Array of Manifest permissions.
 * @return true if all the permissions are granted; false Otherwise.
 */
fun Context?.isPermissionsGranted(permissions: Array<String>): Boolean {
    return this != null &&
            permissions.all {
                ContextCompat.checkSelfPermission(this, it) == PackageManager.PERMISSION_GRANTED
            }
}

/**
 * Checks whether all the permissions passed have permission granted.
 *
 * @param permissions Array of Manifest permissions separated by comma.
 * @return true if all the permissions are granted; false Otherwise.
 */
fun Context?.isPermissionGranted(vararg permissions: String): Boolean {
    return isPermissionsGranted(arrayOf(*permissions))
}

/**
 * Checks whether the [permission] passed have permission granted.
 *
 * @param permission Manifest permission to check
 * @return true if the permission are granted; false Otherwise.
 */
fun Context?.isPermissionGranted(permission: String): Boolean {
    return isPermissionsGranted(arrayOf(permission))
}

/**
 * Returns the resource in Uri format
 *
 * @param resId Resource id.
 * @return [Uri] path of the resource.
 */
fun Context?.resourceToUri(@AnyRes resId: Int): Uri? {
    if (this == null) return null
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
 * @return true if the service is running; false otherwise.
 */
@Suppress("DEPRECATION")
fun Context?.isServiceRunning(serviceClass: KClass<*>): Boolean {
    if (this == null) return false
    val activityManager = ContextCompat.getSystemService(this, ActivityManager::class.java)
    return activityManager?.getRunningServices(Integer.MAX_VALUE)
        ?.any { it.service.className == serviceClass.java.name } ?: false
}

/**
 * Returns the weak reference of the context.
 * @return [WeakReference] instance.
 */
fun Context?.weakReference() = WeakReference(this)

/**
 * Returns the device width in Pixels
 *
 * @return Pixel width in type Integer
 */
fun Context?.getDeviceWidthInPx(): Int {
    this ?: return 0
    val displayMetrics: DisplayMetrics = this.resources.displayMetrics
    return displayMetrics.widthPixels
}

/**
 * Returns the device height in Pixels
 *
 * @return Pixel height in type Integer.
 */
fun Context?.getDeviceHeightInPx(): Int {
    this ?: return 0
    val displayMetrics: DisplayMetrics = this.resources.displayMetrics
    return displayMetrics.heightPixels
}

/**
 * Function to get DeviceType
 * @return MOBILE|TABLET|OTHER
 */
@Deprecated(
    "This function is not required as values might change depending on the platform." +
            " Use Context.isMobile() or Context.isTablet() methods instead.",
    level = DeprecationLevel.ERROR,
    replaceWith =
    ReplaceWith("if (context.isMobile()) \"MOBILE\" else if (context.isTablet()) \"TABLET\" else \"OTHER\"")
)
val Context.deviceType: String
    get() {
        return if (this.isMobile()) "MOBILE" else if (this.isTablet()) "TABLET" else "OTHER"
    }

/**
 * Get Color from res
 *
 * @param id
 * @return color res
 */
fun Context.color(@ColorRes id: Int): Int {
    return ContextCompat.getColor(this, id)
}

/**
 * Get drawable from res
 *
 * @param id
 * @return [Drawable]
 */
fun Context.drawable(@DrawableRes id: Int): Drawable? {
    return ContextCompat.getDrawable(this, id)
}
