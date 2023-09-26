package com.enrichtv.android.player.ui.player.cast;

import android.content.Context
import android.util.Log
import com.google.android.gms.cast.framework.CastOptions
import com.google.android.gms.cast.framework.OptionsProvider
import com.google.android.gms.cast.framework.SessionProvider
import com.google.android.gms.cast.framework.media.CastMediaOptions
import com.google.android.gms.cast.framework.media.NotificationOptions
import com.enrichtv.android.BuildConfig

/**
 * @author Vijay Bhaskar
 * Created on 03/08/23 .
 */
class CastOptionProvider : OptionsProvider {

    override fun getCastOptions(p0: Context): CastOptions {
        Log.e("TAG", "getCastOptions: "+ BuildConfig.CHROME_CAST_ID)
        return CastOptions.Builder()
            .setReceiverApplicationId(BuildConfig.CHROME_CAST_ID)
            .setCastMediaOptions(
                CastMediaOptions
                    .Builder()
                    .setExpandedControllerActivityClassName(ExpandedCastControlActivity::class.java.name)
                    .setNotificationOptions(NotificationOptions.Builder().build())
                    .build()
            ).build()

    }

    override fun getAdditionalSessionProviders(context: Context): List<SessionProvider> {
        return emptyList()
    }
}
