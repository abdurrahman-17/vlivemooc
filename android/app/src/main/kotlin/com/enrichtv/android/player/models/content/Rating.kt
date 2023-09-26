package com.enrichtv.android.player.models.content


import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.VALUE
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class Rating(
    @SerializedName(VALUE)
    val value: Int
):Parcelable
