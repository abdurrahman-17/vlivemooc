@file:Suppress("SpellCheckingInspection")

package com.enrichtv.android.player.models.content


import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.FILE_LIST
import com.enrichtv.android.player.ApiConstant.PG_RATING
import com.enrichtv.android.player.ApiConstant.POSTER_ID
import com.enrichtv.android.player.ApiConstant.POSTER_TYPE
import com.enrichtv.android.player.ApiConstant.TITLE
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class Poster(
    @SerializedName(POSTER_ID)
    val posterid: String?=null,
    @SerializedName(TITLE)
    val title: String?=null,
    @SerializedName(PG_RATING)
    val pgrating: String? =null,
    @SerializedName(POSTER_TYPE)
    val postertype: Orientation?= null,
    @SerializedName(FILE_LIST)
    val fileList: List<FileList>? = listOf()
) : Parcelable
