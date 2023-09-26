package com.enrichtv.android.models

import android.os.Parcelable
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize


/**
 * @author Ashik
 * Created on 8/8/20 .
 */
@Parcelize
@Keep
data class Stream(
    var packageid: String? = null,
    var availabilityId: String? = null,
    var quality: String? = null,
    var streamtype: String? = null,
    var streammode: String? = null,
    var drmscheme: List<String>? = listOf(),
    var streamfilename: String? = null,//mpd or m3u8
    var packagedfilelist: PackageFilelist? = null,
    var videoSize: Long? = null
) : Parcelable

@Parcelize
data class PackageFilelist(
    var audio: List<FileListItem>? = listOf(),
    var video: List<FileListItem>? = listOf(),
    var subtitle: List<FileListItem>? = listOf(),
    var scrubbing: List<Scrubbing>? = listOf()
) : Parcelable

@Parcelize
data class Scrubbing(
    @SerializedName("total") var total: String? = null,
    @SerializedName("column") var column: String? = null,
    @SerializedName("row") var row: String? = null,
    @SerializedName("interval") var interval: String? = null,
    @SerializedName("filename") var filename: String? = null,
    @SerializedName("seekThumbnailImagePath") var seekThumbnailImagePath: String? = null,
    @SerializedName("width") var width: String? = null,
    @SerializedName("height") var height: String? = null
) : Parcelable

@Parcelize
data class FileListItem(
    var filename: String? = null,
    var quality: String? = null,
    var size: String? = null,
    var duration: Int? = null,
    var language: String? = null
) : Parcelable

fun Stream.getScrubbingUrl(): String? {
    return this.streamfilename?.removeLastPathOfUrl()?.plus("/")
        ?.plus(this.packagedfilelist?.scrubbing?.first()?.filename) ?: ""
}


fun String.removeLastPathOfUrl(): String {
    return this.substring(0, this.lastIndexOf('/'))
}
