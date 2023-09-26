package com.enrichtv.android.util

import android.annotation.TargetApi
import android.content.Context
import android.content.res.Configuration
import android.os.Build
import androidx.core.text.TextUtilsCompat
import androidx.core.view.ViewCompat

import java.util.*

/**
 * Helper class which supports changing the language locale
 * @author Mohan
 * @since 20 JAN, 2021
 */
object LocaleHelper {


    /**
     * Returns the locale instance of the language code stored in the shared preference.
     *
     * @param context application context.
     * @return [Locale] instance
     */
    fun getLocale(context: Context): Locale {
        return Locale(/*PrefManager(context).languageCode*/"eng")
    }

    /**
     * Returns the View layout direction based on the locale.
     *
     * @param context Application/Activity/Fragment context.
     * @return Either [ViewCompat.LAYOUT_DIRECTION_LTR] or [ViewCompat.LAYOUT_DIRECTION_RTL]
     */
    @JvmStatic
    fun getLocaleDirection(context: Context?): Int {
        if (context == null) return ViewCompat.LAYOUT_DIRECTION_LTR
        val locale = Locale(/*PrefManager(context).languageCode*/"eng")
        return TextUtilsCompat.getLayoutDirectionFromLocale(locale)
    }

    /**
     * Restarts the entire application.
     *
     * @param context Application context.
     */
   /* fun restartApp(context: Context?) {
        context?.startActivity(Intent(context, SplashActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK
        })
    }*/

    /**
     * Switches the locale based on the language code from the preference.
     *
     * @param context Application context.
     * @return Updated context
     */
    @JvmStatic
    fun switchLocale(context: Context?): Context? {
        if (context == null) return null
        val locale = Locale(/*PrefManager(context).languageCode*/"eng")
        Locale.setDefault(locale)

        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            updateResourcesLocale(context, locale)
        } else updateResourcesLocaleLegacy(context, locale)
    }

    /**
     * Updates the locale configuration for the platforms above Android N.
     *
     * @param context Application context.
     * @param locale Locale to configure.
     * @return Updated context.
     */
    @JvmStatic
    @TargetApi(Build.VERSION_CODES.N)
    private fun updateResourcesLocale(context: Context, locale: Locale): Context? {
        val configuration: Configuration = context.resources.configuration
        configuration.setLocale(locale)
        return context.applicationContext.createConfigurationContext(configuration)
    }

    /**
     * Updates the locale configuration for the platforms below Android N
     *
     * @param context Application context.
     * @param locale Locale to configure.
     * @return Updated context.
     */
    @Suppress("DEPRECATION")
    private fun updateResourcesLocaleLegacy(context: Context, locale: Locale): Context? {
        val resources = context.resources
        val configuration: Configuration = resources.configuration
        configuration.locale = locale
        resources.updateConfiguration(configuration, resources.displayMetrics)
        return context
    }

}
