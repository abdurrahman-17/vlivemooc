package com.enrichtv.android.player.models.content


import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.DURATION
import com.enrichtv.android.player.ApiConstant.FILE_LIST
import com.enrichtv.android.player.ApiConstant.PG_RATING
import com.enrichtv.android.player.ApiConstant.POSTER
import com.enrichtv.android.player.ApiConstant.QUALITY
import com.enrichtv.android.player.ApiConstant.TITLE
import com.enrichtv.android.player.ApiConstant.TRAILER_ID
import com.enrichtv.android.player.ApiConstant.TRAILER_TYPE
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Suppress("SpellCheckingInspection")
@Parcelize
@Keep
data class Trailer(
    @SerializedName(TITLE)
    val title: String?,
    @SerializedName(TRAILER_ID)
    val trailerid: String?,
    @SerializedName(DURATION)
    val duration: Int,
    @SerializedName(FILE_LIST)
    val filelist: List<FileList>?,
    @SerializedName(PG_RATING)
    val pgrating: String?,
    @SerializedName(POSTER)
    val poster: Poster?,
    @SerializedName(QUALITY)
    val quality: String?,
    @SerializedName(TRAILER_TYPE)
    val trailertype: String?
) : Parcelable


