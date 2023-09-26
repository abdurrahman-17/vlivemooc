package com.enrichtv.android.player.ui.player

import android.util.Log
import androidx.core.content.PackageManagerCompat.LOG_TAG
import com.mobiotics.api.ApiError
import okhttp3.Call
import okhttp3.Callback
import okhttp3.MediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.Response
import java.io.IOException


fun getDRMToken(requestBody:String,sessionID:String?,successCallback: (String) -> Unit) {

    val client = OkHttpClient()
    val mediaType = MediaType.parse("application/x-www-form-urlencoded")
    val body = RequestBody.create(mediaType,requestBody)
    val request = Request.Builder()
        .url("https://vcms.mobiotics.com/betav1/subscriber/v1/content/drmtoken")
        .post(body)
        .addHeader("X-SESSION", sessionID)
        .addHeader("Content-Type", "application/x-www-form-urlencoded")
        .build()
    val response = client.newCall(request).enqueue(
        object :Callback{
            override fun onFailure(call: Call, e: IOException) {
               //Need to handle the callback of failure
            }

            override fun onResponse(call: Call, response: Response) {
                successCallback.invoke(response.body().toString())

            }

        }
    )


}