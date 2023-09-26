/**
 * This class use to store shared preference data
 * */
package com.enrichtv.android.db

import android.annotation.SuppressLint
import android.content.Context
import android.content.SharedPreferences
import com.enrichtv.android.player.ApiConstant.SHORT_EN
import com.enrichtv.android.player.ApiConstant.SHORT_MAL
import com.enrichtv.android.player.ApiConstant.SHORT_MAR
import com.enrichtv.android.player.ApiConstant.SHORT_ML
import com.enrichtv.android.player.ApiConstant.SHORT_MR
import com.enrichtv.android.player.Constants
import com.enrichtv.android.player.Constants.EMPTY_STRING
import java.util.Locale

/**
 * @author Ratnesh Kumar Ratan
 * @since 17/03/2020
 **/
@Suppress("TooGenericExceptionCaught")
class PrefManager/* @Inject*/ constructor(private val context: Context) {


    /**
     * Creates Shared Preference Editor object for editing preference values
     *
     * @author Ratnesh Kumar Ratan
     * @since 17/03/2020
     **/
    private val editor: SharedPreferences.Editor
        @SuppressLint("CommitPrefEdits") get() = preference.edit()

    /**
     * Create shared preference
     *
     * @author Ratnesh Kumar Ratan
     * @since 17/03/2020
     **/
    private val preference: SharedPreferences
        get() = context.getSharedPreferences(Constants.PREFERENCE_NAME, Context.MODE_PRIVATE)

    /**
     * Returns the [appLanguage] in ISO 639-1 format.
     */
    val languageCode: String
        get() = /*if (appConfig?.featureEnabled?.isDeckingConfigEnabled == true) appLanguage else {*/
            if (appLanguage.isNotEmpty()) {
                when (appLanguage.toLowerCase(
                    Locale.ENGLISH
                )) {
                    SHORT_MAR -> SHORT_MR
                    SHORT_MAL -> SHORT_ML
                    else -> appLanguage.substring(0, 2)
                }
            } else SHORT_EN
    // }




    /**
     * Save and retrieve app language
     *
     * @author Ratnesh Kumar Ratan
     * @since 17/03/2020
     */
    var appLanguage: String
        get() = preference.getString(Constants.APP_LANGUAGE, EMPTY_STRING)!!
        set(value) {
            editor.putString(Constants.APP_LANGUAGE, value).apply()
        }



    companion object {

        /**
         * Key for the language list
         */
        private const val LANGUAGE_LIST = "language_list"
        private const val DEFAULT_TEXT = "default"

        private const val KEY_FCM = "topic.subscribed.FCM"
        private const val DOWNLOAD_SETTINGS = "download_settings"
    }

}
