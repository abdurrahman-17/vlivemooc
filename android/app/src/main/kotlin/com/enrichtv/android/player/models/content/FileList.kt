package com.enrichtv.android.player.models.content

import android.os.Parcelable
import androidx.annotation.Keep

import com.google.gson.annotations.SerializedName
import com.enrichtv.android.player.ApiConstant.FILE_NAME
import com.enrichtv.android.player.ApiConstant.QUALITY
import kotlinx.android.parcel.Parcelize

/**
 * @author Ratnesh Kumar Ratan
 * @since 7/8/20
 **/
@Parcelize
@Keep
class FileList(
    @SerializedName(FILE_NAME)
    var fileName: String? = null,
    @SerializedName(QUALITY)
    var quality: String?
) : Parcelable



