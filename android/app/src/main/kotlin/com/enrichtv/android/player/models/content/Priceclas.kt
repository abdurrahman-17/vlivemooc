@file:Suppress("SpellCheckingInspection")

package com.enrichtv.android.player.models.content


import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.CURRENCY
import com.enrichtv.android.player.ApiConstant.PRICE
import com.enrichtv.android.player.ApiConstant.PRICE_CLASS_TYPE
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class Priceclas(
    @SerializedName(CURRENCY)
    val currency: String?,
    @SerializedName(PRICE)
    val price: String?,
    @SerializedName(PRICE_CLASS_TYPE)
    val priceclasstype: String?
) : Parcelable
