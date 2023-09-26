package com.enrichtv.android.player

import android.app.Application
import com.enrichtv.android.R
import com.mobiotics.player.core.Mode
import com.mobiotics.player.core.PlayerConfig
import com.mobiotics.player.core.drm.DrmInfo
import com.mobiotics.player.core.drm.DrmRequestFormat
import com.mobiotics.player.core.drm.DrmRequestInfo
import com.mobiotics.player.exo.PlayerComponent
import com.mobiotics.player.exo.config.DefaultConfiguration
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob

/**
 * Application
 */
class App : Application() {

    //private var config: Config? = null


    /**
     * true if player initialized; false otherwise.
     */
    var isPlayerInitialized: Boolean = false

    override fun onCreate() {
        super.onCreate()
        // initBugFender()
        // firebaseHelper.get().enablePersistence()
        // For google sign-in
        // SocialSdk.getInstance().setGoogleWebClientId(getString(R.string.default_web_client_id))
        //observeConfig()
        //initializeMobiAnalytics()
        //startKochavaSDK()
    }


    fun initPlayerConfig() {
        if (!isPlayerInitialized) {
            // https://vdrm.mobiotics.com/betav1/proxy/v1/license
            //"https://gogo.mobiotics.com:8081/proxy/v1/license?vendorid=wlqtn908"
            //val vendorDetails = databaseHelper.get().getConfigInMainThread()?.vendorDetails
            val licenseUrl = "https://xph4hpyebd.execute-api.ap-south-1.amazonaws.com/slsdev/license/" /*+ vendorDetails?.drmUrl*/

            PlayerComponent.initialize(
                PlayerConfig(
                    Mode.Debug,
                    DrmInfo(
                        licenseUrl!!,
                        DrmRequestInfo(
                            requestDataKey = "payload",
                            format = DrmRequestFormat.FORM_DATA
                        )
                    ),
                    false
                ),
                DefaultConfiguration(applicationContext, getString(R.string.app_name))
            )
            isPlayerInitialized = true
        }
    }

    val appCoroutineScope: CoroutineScope
        get() = CoroutineScope(SupervisorJob() + Dispatchers.Default)

}
