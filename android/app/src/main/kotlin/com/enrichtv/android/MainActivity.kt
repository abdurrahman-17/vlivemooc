package com.enrichtv.android

import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.util.Base64
import android.util.Log
import androidx.annotation.NonNull
import com.enrichtv.android.player.Constants
import com.enrichtv.android.player.ui.player.PlayerActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import io.flutter.embedding.android.FlutterFragmentActivity


lateinit  var flutterEngineGobal:FlutterEngine ;
class MainActivity: FlutterFragmentActivity() {

    private val CHANNEL = "com.mobiotics.media"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngineGobal = flutterEngine
        //generateFBHashKey()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "openPlayer") {
                result.success("Player started")

                val playerIntent = Intent(this,PlayerActivity::class.java)
                playerIntent.apply{

                    putExtra("content",call.argument("content") as String? )
                    putExtra("licenseServer", call.argument("licenseServer")as String?)
                    putExtra("packageid", call.argument("packageid")as String?)
                    putExtra("sessionToken", call.argument("sessionToken")as String?)
                    putExtra("Seasons", call.argument("Seasons")as String?)
                    putExtra("Episodes", call.argument("Episodes")as String?)
                    putExtra("playlist", call.argument("playlist")as String?)
                    putExtra(Constants.playerSecurity, call.argument(Constants.playerSecurity)as String?)

                }
                /*val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.mobiotics.androidplayer")
                channel.invokeMethod("updateWatchedPercentage", "Hello from Kotlin!")*/
                startActivity(playerIntent)
                //Toast.makeText(this@MainActivity, "This toast is natively created!", Toast.LENGTH_SHORT).show()

                // result.error("ERROR", "YOUR ERROR HERE", null)

            } else {
                result.notImplemented()
            }

        }
    }

    private fun generateFBHashKey() {
        try {
            val info: PackageInfo = packageManager.getPackageInfo(
                "com.example.vlite",
                PackageManager.GET_SIGNATURES
            )
            for (signature in info.signatures) {
                val md = MessageDigest.getInstance("SHA")
                md.update(signature.toByteArray())
                Log.d("KeyHash:", Base64.encodeToString(md.digest(), Base64.DEFAULT))
            }
        } catch (e: PackageManager.NameNotFoundException) {
        } catch (e: NoSuchAlgorithmException) {
        }
    }


}
