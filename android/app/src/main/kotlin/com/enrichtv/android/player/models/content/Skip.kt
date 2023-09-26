package com.enrichtv.android.models.content

import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Suppress("SpellCheckingInspection")
@Parcelize
@Keep
data class Skip(
    @SerializedName(ApiConstant.SKIP_TYPE)
    val skiptype: SkipPlayer,
    @SerializedName(ApiConstant.START)
    val start: Int? = null,
    @SerializedName(ApiConstant.END)
    val end: Int? = null,
    @SerializedName(ApiConstant.USER_TYPE)
    val userType: Boolean?
) : Parcelable{
    enum class SkipPlayer {
        @SerializedName("INTRO")
        INTRO,
        @SerializedName("CREDITS")
        CREDITS,
        @SerializedName("ADS")
        ADS,
        @SerializedName("USER DEFINED")
        USERDEFINED
    }
}
