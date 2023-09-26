/** This class provide video drm authorization **/
package com.enrichtv.android.ui.player

import android.content.Context
import com.enrichtv.android.player.models.content.Content
import com.mobiotics.player.core.drm.DrmAuthenticator
import com.mobiotics.player.core.media.Media
import com.enrichtv.android.player.ApiConstant
import com.enrichtv.android.util.currentUTCTime
import okhttp3.MediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody

import org.json.JSONObject

/**
 * @author Ratnesh Kumar Ratan
 * @since 26/3/20
 **/

class VideoDrmAuthenticator(
    private val packageId: String,
    private val sessionJwt: String?,
    context: Context,
) : DrmAuthenticator<Content> {
    override fun authorize(media: Media<Content>): Map<String, Any> {

        val packageId = media.t?.contentStream?.packageid ?: ""


       var requestBody =  "drmscheme=${media.t?.contentStream?.drmscheme?.first()}&availabilityid=" +
               "${media.t?.contentStream?.availabilityId}&seclevel=5677&offline=NO&contentid=${media.id}&packageid=${packageId}"

        val client = OkHttpClient()
        val mediaType = MediaType.parse("application/x-www-form-urlencoded")
        val body = RequestBody.create(mediaType,requestBody)
        val request = Request.Builder()
            .url("https://vcms.mobiotics.com/betav1/subscriber/v1/content/drmtoken")
            .post(body)
            .addHeader("X-SESSION", sessionJwt)
            .addHeader("Content-Type", "application/x-www-form-urlencoded")
            .build()

        val drmToken = client.newCall(request).execute()

       return   hashMapOf(
            "providerid" to ("enrichtv" ?: ""),
            "contentid" to (media.id),
            "drmscheme" to (media.t?.contentStream?.drmscheme?.first() ?: "NONE"),
            ApiConstant.TIME_STAMP to currentUTCTime(),
            "customdata" to JSONObject().apply {
                put("packageid", packageId)
                put("drmtoken", drmToken)
            }
        )


    }




    override fun query(media: Media<Content>): Map<String, String> {
        return emptyMap()
    }

    override fun headers(media: Media<Content>): Map<String, String> {
        return sessionJwt?.let {  hashMapOf("X-SESSION" to sessionJwt)}?: emptyMap()
    }


}
