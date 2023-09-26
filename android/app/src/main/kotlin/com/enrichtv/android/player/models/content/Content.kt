/**
 * Model class for Content data
 * */
@file:Suppress("SpellCheckingInspection")

package com.enrichtv.android.player.models.content

import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.ALBUM_ID
import com.enrichtv.android.player.ApiConstant.BANDOR_ARTIST
import com.enrichtv.android.player.ApiConstant.CATEGORY
import com.enrichtv.android.player.ApiConstant.CITY
import com.enrichtv.android.player.ApiConstant.CONTENT
import com.enrichtv.android.player.ApiConstant.CONTENT_LANGUAGE
import com.enrichtv.android.player.ApiConstant.CONTEN_TOWNER
import com.enrichtv.android.player.ApiConstant.DETAILS
import com.enrichtv.android.player.ApiConstant.DURATION
import com.enrichtv.android.player.ApiConstant.EPISODE_COUNT
import com.enrichtv.android.player.ApiConstant.EPISODE_NUM
import com.enrichtv.android.player.ApiConstant.GENRE
import com.enrichtv.android.player.ApiConstant.HD
import com.enrichtv.android.player.ApiConstant.IS_BLANK
import com.enrichtv.android.player.ApiConstant.ITEM_LIST
import com.enrichtv.android.player.ApiConstant.LOW
import com.enrichtv.android.player.ApiConstant.NUM_VIEWS
import com.enrichtv.android.player.ApiConstant.OBJECT_ID
import com.enrichtv.android.player.ApiConstant.OBJECT_TAG
import com.enrichtv.android.player.ApiConstant.OBJECT_TYPE
import com.enrichtv.android.player.ApiConstant.PG_RATING
import com.enrichtv.android.player.ApiConstant.POSTER
import com.enrichtv.android.player.ApiConstant.PRODUCTION_YEAR
import com.enrichtv.android.player.ApiConstant.RATING
import com.enrichtv.android.player.ApiConstant.RATING_TYPE
import com.enrichtv.android.player.ApiConstant.RELEASE_DATE
import com.enrichtv.android.player.ApiConstant.SD
import com.enrichtv.android.player.ApiConstant.SEASON_COUNT
import com.enrichtv.android.player.ApiConstant.SEASON_NUM
import com.enrichtv.android.player.ApiConstant.SERIES_ID
import com.enrichtv.android.player.ApiConstant.SERIES_NAME
import com.enrichtv.android.player.ApiConstant.SHORT_DESCRIPTION
import com.enrichtv.android.player.ApiConstant.SUBSCRIBER_ID
import com.enrichtv.android.player.ApiConstant.SUB_CATEGORY
import com.enrichtv.android.player.ApiConstant.SUB_GENRE
import com.enrichtv.android.player.ApiConstant.TAGS
import com.enrichtv.android.player.ApiConstant.THUMBNAIL
import com.enrichtv.android.player.ApiConstant.TILL_DATE
import com.enrichtv.android.player.ApiConstant.TITLE
import com.enrichtv.android.player.ApiConstant.TRACK
import com.enrichtv.android.player.ApiConstant.TRACK_COUNT
import com.enrichtv.android.player.ApiConstant.TRAILER
import com.enrichtv.android.player.ApiConstant.VENUE

import com.google.gson.annotations.SerializedName
import com.mobiotics.core.extensions.isNotNull
import com.mobiotics.core.extensions.isNull
import com.enrichtv.android.player.ApiConstant.LONG_DESCRIPTION
import com.enrichtv.android.player.ApiConstant.POSTER_LINK
import com.enrichtv.android.player.ApiConstant.SKIP
import com.enrichtv.android.player.Constants.EMPTY_STRING
import com.enrichtv.android.player.Constants.MINUS_DEFAULT
import com.enrichtv.android.models.Stream
import com.enrichtv.android.models.config.SubContents
import com.enrichtv.android.models.content.Skip
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class Content(
    @SerializedName(OBJECT_ID)
    var objectid: String = "",
    @SerializedName(ALBUM_ID)
    var albumid: String? = null,
    @SerializedName(BANDOR_ARTIST)
    var bandOrArtist: String? = null,
    @SerializedName(CATEGORY)
    var category: CategoryType? = null,
    @SerializedName(CONTENT, alternate = ["contentdetails"])
    var listDetails: List<ContentDetails>? = listOf(),
    @SerializedName(CONTENT_LANGUAGE)
    var contentLanguage: List<String>? = null,
    @SerializedName(CONTEN_TOWNER)
    var contentOwner: String? = null,
    @SerializedName(DETAILS)
    var details: Details? = null,
    @SerializedName(DURATION)
    var duration: Int = 0,
    @SerializedName(EPISODE_NUM)
    var episodeNum: String? = null,
    @SerializedName(GENRE)
    var genre: String? = null,
    @SerializedName(EPISODE_COUNT)
    var episodeCount: Int? = null,
    @SerializedName(NUM_VIEWS)
    var numviews: String? = null,
    @SerializedName(OBJECT_TYPE)
    var objectType: ObjectType? = null,
    @SerializedName(PG_RATING)
    var pgRating: String? = null,
    @SerializedName(POSTER)
    var poster: List<Poster>? = listOf(),
    @SerializedName(PRODUCTION_YEAR)
    var productionYear: String? = null,
    @SerializedName(RATING)
    var rating: Rating? = null,
    @SerializedName(RATING_TYPE)
    var ratingType: String? = null,
    @SerializedName(RELEASE_DATE)
    var releaseDate: String? = null,
    @SerializedName(SEASON_NUM)
    var seasonNum: Int? = null,
    @SerializedName(SEASON_COUNT)
    var seasonCount: String? = null,
    @SerializedName(SERIES_ID)
    var seriesid: String? = null,
    @SerializedName(SHORT_DESCRIPTION)
    var shortDescription: String? = null,
    @SerializedName(SUB_GENRE)
    var subgenre: List<String>? = null,
    @SerializedName(TAGS)
    var tags: List<String>? = null,
    @SerializedName(TILL_DATE)
    var tillDate: String? = null,
    @SerializedName(TITLE)
    var title: String? = null,
    @SerializedName(TRACK)
    var track: String? = null,
    @SerializedName(SUBSCRIBER_ID)
    var subscriberId: String? = null,
    @SerializedName(TRAILER)
    var trailer: List<Trailer>?,
    @SerializedName(IS_BLANK)
    var isBlank: Boolean = false,
    @SerializedName(ITEM_LIST)
    var itemList: List<String>? = listOf(),
    @SerializedName(SERIES_NAME)
    var seriesName: String? = null,
    var isCurrentseries: Boolean = false,
    var profileId: String? = null,
    var videoSize: Long? = null,
    @SerializedName(THUMBNAIL)
    val thumbnail: String? = null,
    @SerializedName(OBJECT_TAG)
    var objectTag: List<String>? = null,
    @SerializedName(SUB_CATEGORY)
    val subCategory: String? = null,
    @SerializedName(TRACK_COUNT)
    val trackcount: String? = null,
    @SerializedName(VENUE)
    val venue: String? = null,
    @SerializedName(CITY)
    val city: String? = null,
    @SerializedName(LONG_DESCRIPTION)
    val longDescription: String? = null,
    @SerializedName(SKIP)
    val skip: List<Skip>? = null,
    @SerializedName("watchedDuration")
    var watchedDuration: Long? = null,
    @SerializedName("playlead")
    var playlead: String? = null,

    var description: String? = null,
    var objectstatus: ObjectStatus? = null,
    var jobid: String? = null,
    var imdbid: String? = null,
    @SerializedName("contentStream")
    var contentStream: Stream? = null,
    var isTrailer: Boolean = false,
    var seasonid: String? = null,
    var subContents: SubContents? = null,
    @SerializedName(POSTER_LINK)
    var posterLink: String? = null,
    var isAdded: Boolean = false,
    var defaulttitle: String? = null,
    var defaultgenre: String? = null,
    var advisory: String? = null,
    var metacontent: MetaContent? = null,
    var castncrew: CastCrew? = null,
    var isChecked: Boolean = false,


    ) : Parcelable {

    /**
     * When pass a blank object use this constructor
     *
     * @modifier Sudhir Kumar
     * @since 31/03/2020
     */
    @Keep
    constructor(isBlank: Boolean) : this(
        EMPTY_STRING,
        EMPTY_STRING,
        EMPTY_STRING,
        null,
        emptyList(),
        null,
        EMPTY_STRING,
        null,
        MINUS_DEFAULT,
        null,
        EMPTY_STRING,
        null,
        EMPTY_STRING,
        null,
        EMPTY_STRING,
        emptyList<Poster>(),
        EMPTY_STRING,
        Rating(MINUS_DEFAULT),
        EMPTY_STRING,
        null,
        0,
        EMPTY_STRING,
        EMPTY_STRING,
        EMPTY_STRING,
        null,
        emptyList<String>(),
        EMPTY_STRING,
        EMPTY_STRING,
        EMPTY_STRING,
        EMPTY_STRING,
        null,
        isBlank,
        null,
        null,
        false,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        skip = null,
        advisory = null,
        metacontent = null,
        castncrew = null
    )
}

@Keep
enum class Orientation {
    PORTRAIT, LANDSCAPE, SQUARE
}


fun Content.getTrailer(): Trailer? {
    trailer?.forEach { trailer ->
        for (quality in SORT_ORDER) {
            if (trailer.quality == quality) {
                return trailer
            }
        }
    }
    return null
}


fun Trailer.getFileList(): FileList? {
    filelist?.forEach { fileList ->
        for (quality in SORT_ORDER) {
            if (fileList.quality == quality) {
                return fileList
            }
        }
    }
    return null
}

internal var SORT_ORDER = arrayOf(SD, LOW, THUMBNAIL, HD)

fun Content.poster(orientation: Orientation): String? {
    var posterData = poster?.find { it.postertype == orientation }
    if (posterData.isNull()) {
        posterData =
            poster?.find { it.postertype == Orientation.PORTRAIT || it.postertype == Orientation.LANDSCAPE || it.postertype == Orientation.SQUARE }
    }
    val fileList = posterData?.fileList
    if (fileList.isNullOrEmpty()) return null
    val sorteList = if (fileList.size == 1) fileList
    else {
        val mList = fileList.toMutableList()
        val index = mList.indexOfFirst { it.quality == HD }
        if (index != -1) {
            val hd = mList.removeAt(index)
            mList.add(hd)
        }
        mList
    }
    return sorteList.firstOrNull()?.fileName
    /*val list: List<Poster>? = poster?.filter { it.postertype == orientation }
    list?.forEach { poster ->
        for (quality in SORT_ORDER) {
            val fileList =
                poster.fileList?.find { posterQuality -> posterQuality.quality == quality }
            if (fileList != null)
                return fileList.fileName
        }
    }
    return list?.find { it ->
        it.fileList?.find { it.quality.equals(Constants.QUALITY_HD, true) }.isNotNull()
    }?.fileList?.first()?.fileName*/
}

fun createAdditionalParamForDetailApi(
    country: String? = null,
    region: String? = null,
    description: String? = null
): MutableMap<String, String?> {
    val mapParam: MutableMap<String, String?> = mutableMapOf()
    mapParam.apply {
        if (country.isNotNull()) put("country", country)
        if (region.isNotNull()) put("region", region)
        if (description.isNotNull()) put("description", description)
    }
    return mapParam
}

/**
 * Returns whether the Content type is Music or not.
 *
 * @return true if music; false otherwise
 */
fun Content?.isTypeMusic(): Boolean {
    if (this == null) return false
    return objectType == ObjectType.ALBUM && category == CategoryType.MUSIC
}

/**
 * Returns whether the Content type is Online Radio or not.
 *
 * @return true if online radio; false otherwise.
 */
fun Content?.isTypeRadio(): Boolean {
    if (this == null) return false
    return (objectType == ObjectType.CHANEL || category == CategoryType.ONLINE) && genre == "RADIO"
}
