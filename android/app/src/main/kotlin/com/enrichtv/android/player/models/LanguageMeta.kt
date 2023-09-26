package com.enrichtv.android.models


import android.os.Parcelable
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Keep
@Parcelize
data class LanguageMeta(
    @SerializedName(value = "title", alternate = ["castncrewname", "planname"])
    val title: String? = null,
    @SerializedName(value = "description", alternate = ["instruction"])
    val description: String? = null,
    @SerializedName("language") val language: String? = null // kan
) : Parcelable
