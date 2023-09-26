package com.enrichtv.android.models.config

import android.os.Parcelable
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName
import com.enrichtv.android.player.Constants.DEEPLINK
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class SubContents(
    @SerializedName(DEEPLINK)
    val deepLink: String?,
    val isEnabled: Boolean = false,
    val position: Int?,
    val poster: Map<String, Map<String, String>>?,
    val userTypes : List<String>?
): Parcelable
