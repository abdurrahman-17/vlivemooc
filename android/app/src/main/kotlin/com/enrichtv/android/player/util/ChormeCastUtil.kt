package com.enrichtv.android.player.util

import android.app.Activity
import android.content.Context
import android.net.Uri
import androidx.core.content.ContextCompat

import com.enrichtv.android.player.ApiConstant.CONTENT_ID
import com.enrichtv.android.player.ApiConstant.DRM_TOKEN
import com.enrichtv.android.player.ApiConstant.PACKAGE_ID
import com.enrichtv.android.player.ApiConstant.PROVIDER_ID
import com.enrichtv.android.player.ApiConstant.SUBSCRIBERID

import com.enrichtv.android.player.models.content.Content
import com.enrichtv.android.player.models.content.ObjectType
import com.enrichtv.android.player.models.content.Orientation
import com.enrichtv.android.player.models.content.poster
import com.google.android.gms.cast.MediaInfo
import com.google.android.gms.cast.MediaLoadOptions
import com.google.android.gms.cast.MediaMetadata
import com.google.android.gms.cast.TextTrackStyle
import com.google.android.gms.cast.TextTrackStyle.DEFAULT_FONT_SCALE
import com.google.android.gms.cast.TextTrackStyle.FONT_STYLE_NORMAL
import com.google.android.gms.cast.framework.media.RemoteMediaClient
import com.google.android.gms.common.images.WebImage
import com.mobiotics.core.jsonObject
import com.enrichtv.android.R
import com.enrichtv.android.BuildConfig



/**
 * Start chrome cast
 * @param item [MediaInfo]
 * @param positionMs Playback position
 * @param playWhenReady player status
 * @param rmClient [RemoteMediaClient]
 *
 * */
fun Activity?.startCast(
    item: MediaInfo?,
    positionMs: Long,
    playWhenReady: Boolean,
    rmClient: RemoteMediaClient
) {
    if (this == null) return
    if (item == null) return
    rmClient.load(
        item,
        MediaLoadOptions.Builder().setAutoplay(playWhenReady).setPlayPosition(positionMs).build()
    )
}


/**
 * Build Media queue item
 * @param context [Context]
 * @param drmToken Drm token
 * @param subscriberId subscribed Id
 *
 * @return MediaInfo?
 *
 * */
fun Content?.buildMediaQueueItem(
    context: Context?,
    drmToken: String?,
    xsession:String?,
    subscriberId: String?
): MediaInfo? {
    if (this == null || subscriberId == null || context == null) return null

    val movieMetadata = this.createMediaMetadata(subscriberId, false, BuildConfig.PROVIDER_ID)
    val textTrackStyle = TextTrackStyle()
    textTrackStyle.apply {
        foregroundColor = ContextCompat.getColor(context, R.color.c_white_1)
        backgroundColor = ContextCompat.getColor(context, R.color.c_black_14)
        fontStyle = FONT_STYLE_NORMAL
        fontScale = DEFAULT_FONT_SCALE
    }
    var mediaInfoBuilder: MediaInfo? = null
    try {
        mediaInfoBuilder = MediaInfo.Builder(this.contentStream?.streamfilename?:"").apply {
            setContentUrl(this@buildMediaQueueItem.contentStream?.streamfilename?:"")
            setStreamType(MediaInfo.STREAM_TYPE_BUFFERED)
            setContentType(com.google.android.exoplayer2.util.MimeTypes.APPLICATION_MPD)
            setMetadata(movieMetadata)
            this.setCustomData(jsonObject {
                put(PACKAGE_ID, this@buildMediaQueueItem.contentStream?.packageid)
                put(DRM_TOKEN, drmToken)
                put(CONTENT_ID, this@buildMediaQueueItem.objectid)
                put("providerid", BuildConfig.PROVIDER_ID)
                put("X-SESSION",xsession)
            })
            setStreamDuration(this@buildMediaQueueItem.duration.toLong())
            setTextTrackStyle(textTrackStyle)
        }.build()
    } catch (exception: IllegalArgumentException) {
        //do nothing
    }
    return mediaInfoBuilder
}


/**
 * Create metadata
 * @param subscriberId SubscriberId
 * @param trailer is trailer/not
 * @param vendor vendor
 *
 * */
@Suppress("TooGenericExceptionCaught")
fun Content.createMediaMetadata(
    subscriberId: String,
    trailer: Boolean,
    vendor: String
): MediaMetadata {
    //FirebaseCrashlytics.getInstance().log("Called Content.createMediaMetadata() -> $objectid, $title")
    val movieMetadata = MediaMetadata(MediaMetadata.MEDIA_TYPE_MOVIE)
    movieMetadata.putString(MediaMetadata.KEY_TITLE, title?:"")
    movieMetadata.putString(
        MediaMetadata.KEY_SUBTITLE,
        this.description ?: this.shortDescription ?: this.longDescription?:""
    )
    if (!trailer) {
        movieMetadata.putString(CONTENT_ID, objectid)
        movieMetadata.putString(PROVIDER_ID, vendor)
        movieMetadata.putString(SUBSCRIBERID, subscriberId)
    }
    try {
        val imageUrl =
            if (this.objectType == ObjectType.MUSIC) poster(Orientation.SQUARE)
            else poster(Orientation.LANDSCAPE)
        if (imageUrl != null) {
            movieMetadata.addImage(WebImage(Uri.parse(imageUrl)))
            movieMetadata.putString("castComponentPosterURL", imageUrl)
        }
    } catch (e: NoSuchFileException) {
       // FirebaseCrashlytics.getInstance().recordException(e)
    } catch (e: NullPointerException) {
        //FirebaseCrashlytics.getInstance().recordException(e)
    }
    return movieMetadata
}


