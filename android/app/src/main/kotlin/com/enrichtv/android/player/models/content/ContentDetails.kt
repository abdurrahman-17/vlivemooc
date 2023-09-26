package com.enrichtv.android.player.models.content


import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.LEVEL_ID
import com.enrichtv.android.player.ApiConstant.LEVEL_TYPE
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Suppress("SpellCheckingInspection")
@Parcelize
@Keep
data class ContentDetails(
    var packageid: String? = null,
    var availabilityset: List<String>? = null,
    var mediaid: String? = null,
    var quality: String? = null,
    var jobid: String? = null,
    var streamtype: String? = null,
    var streammode: String? = null,
    var drmscheme: List<String>? = null,
    var objectid: String? = null,
    var clearlead: Int? = null,
    var subtitlelang: List<String>? = null,
    var audiolang: List<String>? = null,
    @SerializedName(LEVEL_ID)
    val levelID: String? = null,
    @SerializedName(LEVEL_TYPE)
    val levelType: LevelType? = null
) : Parcelable
