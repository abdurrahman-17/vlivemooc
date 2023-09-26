/** This class provide Track name provider **/
package com.enrichtv.android.ui.player

import android.content.res.Resources
import android.graphics.Color
import android.os.Build
import android.text.SpannableStringBuilder
import android.text.SpannedString
import android.text.TextUtils
import androidx.core.text.buildSpannedString
import androidx.core.text.color
import com.enrichtv.android.R
import com.google.android.exoplayer2.C
import com.google.android.exoplayer2.Format
import com.google.android.exoplayer2.util.Assertions
import com.google.android.exoplayer2.util.MimeTypes
import com.mobiotics.core.extensions.format
import com.mobiotics.player.exo.track.TrackNameProvider
import com.enrichtv.android.player.Constants
import java.math.RoundingMode
import java.util.*

/**
 * @author Ratnesh Kumar Ratan
 * @since 04/04/2020
 */
class PlayerTrackNameProvider(resources: Resources, private val hasDownloadTrack: Boolean = false) :
    TrackNameProvider {

    private val resources: Resources = Assertions.checkNotNull(resources)

    override fun getTrackName(format: Format): CharSequence {
        val trackName: CharSequence
        val trackType = inferPrimaryTrackType(format)
        trackName = when (trackType) {
            C.TRACK_TYPE_VIDEO -> if (hasDownloadTrack) buildResolutionForDownloadTrack(format) else buildResolutionString(
                format
            )
            C.TRACK_TYPE_AUDIO -> buildLanguageOrLabelString(format)
            else -> buildLanguageOrLabelString(format)
        }
        return if (trackName.isEmpty()) resources.getString(R.string.exo_track_unknown) else trackName
    }

    private fun inferPrimaryTrackType(format: Format): Int {
        val trackType = MimeTypes.getTrackType(format.sampleMimeType)
        if (trackType != C.TRACK_TYPE_UNKNOWN) {
            return trackType
        }
        if (MimeTypes.getVideoMediaMimeType(format.codecs) != null) {
            return C.TRACK_TYPE_VIDEO
        }
        if (MimeTypes.getAudioMediaMimeType(format.codecs) != null) {
            return C.TRACK_TYPE_AUDIO
        }
        if (format.width != Format.NO_VALUE || format.height != Format.NO_VALUE) {
            return C.TRACK_TYPE_VIDEO
        }
        return if (format.channelCount != Format.NO_VALUE || format.sampleRate != Format.NO_VALUE) {
            C.TRACK_TYPE_AUDIO
        } else C.TRACK_TYPE_UNKNOWN
    }

    private fun buildResolutionString(format: Format): CharSequence {
        val width = format.width
        val height = format.height
        return if (width == Format.NO_VALUE || height == Format.NO_VALUE)
            Constants.EMPTY_STRING
        else {
            if (height == 720 || height == 1080) {
                val qualityVar = resources.getString(R.string.exo_hd_format, height.toString())
                val spr = SpannableStringBuilder(qualityVar).color(Color.RED) {
                    append(resources.getString(R.string.exo_hd_format_color))
                }
                spr
            } else
                height.toString() + "p"
        }
    }

    private fun buildResolutionForDownloadTrack(format: Format): CharSequence {
        val width = format.width
        val height = format.height
        val bitrate =
            if (format.bitrate == Format.NO_VALUE) Constants.EMPTY_STRING else buildBitrateString(
                format
            )
        var leftVideoResolution = Constants.EMPTY_STRING
        var rightVideoSize = Constants.EMPTY_STRING
        if (width == Format.NO_VALUE || height == Format.NO_VALUE)
            return Constants.EMPTY_STRING
        else
            return when (height) {
                Constants.VIDEO_QUALITY_480, Constants.VIDEO_QUALITY_360, Constants.VIDEO_QUALITY_240 -> {
                    /*resources.getString(string.resolution_low, height, bitrate)*/
                    generateAlignedTrackName(
                        "${
                            Constants.QUALITY_LOW.toUpperCase(Locale.ENGLISH)
                            .capitalize()}- $height", "$bitrate ${Constants.VIDEO_SIZE_FORMAT_MB} "
                    )
                }
                Constants.VIDEO_QUALITY_720 -> {
                    /*resources.getString(string.resolution_hd, height, bitrate)*/
                    generateAlignedTrackName(
                        "${Constants.QUALITY_HD.toUpperCase(Locale.ENGLISH).capitalize()}- $height",
                        "$bitrate ${Constants.VIDEO_SIZE_FORMAT_MB} "
                    )
                }
                Constants.VIDEO_QUALITY_1080 -> {
                    /*resources.getString(string.resolution_full_hd, height, bitrate)*/
                    generateAlignedTrackName(
                        "${Constants.QUALITY_FULL_HD}- $height",
                        "$bitrate ${Constants.VIDEO_SIZE_FORMAT_MB}"
                    )
                }
                else -> {
                    "${height}p"
                }
            }
    }

    private fun buildBitrateString(format: Format): String? {
        val bitrate = format.bitrate
        var value = 0.00
        try {
            value = if (bitrate == Format.NO_VALUE) 0.00 else (bitrate / 1000000f).toDouble()
        } catch (e: NullPointerException) {
        }
        return value.format(roundingMode = RoundingMode.HALF_UP)
    }

    private fun buildLanguageOrLabelString(format: Format): String {
        val languageAndRole =
            joinWithSeparator(buildLanguageString(format), buildRoleString(format))
        return if (TextUtils.isEmpty(languageAndRole)) buildLabelString(format) else languageAndRole
    }

    private fun buildLabelString(format: Format): String {
        return if (TextUtils.isEmpty(format.label)) Constants.EMPTY_STRING else format.label
            ?: resources.getString(R.string.exo_track_unknown)
    }

    private fun buildLanguageString(format: Format): String {
        val language = format.language ?: Constants.EMPTY_STRING
        if (TextUtils.isEmpty(language) || C.LANGUAGE_UNDETERMINED == language) {
            return Constants.EMPTY_STRING
        }
        val locale =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) Locale.forLanguageTag(
                language
            ) else Locale(
                language
            )
        return locale.displayName
    }

    private fun buildRoleString(format: Format): String {
        var roles = Constants.EMPTY_STRING
        if (format.roleFlags and C.ROLE_FLAG_ALTERNATE != 0) {
            roles = resources.getString(R.string.exo_track_role_alternate)
        }
        if (format.roleFlags and C.ROLE_FLAG_SUPPLEMENTARY != 0) {
            roles =
                joinWithSeparator(roles, resources.getString(R.string.exo_track_role_supplementary))
        }
        if (format.roleFlags and C.ROLE_FLAG_COMMENTARY != 0) {
            roles =
                joinWithSeparator(roles, resources.getString(R.string.exo_track_role_commentary))
        }
        if (format.roleFlags and (C.ROLE_FLAG_CAPTION or C.ROLE_FLAG_DESCRIBES_MUSIC_AND_SOUND) != 0) {
            roles = joinWithSeparator(
                roles,
                resources.getString(R.string.exo_track_role_closed_captions)
            )
        }
        return roles
    }

    private fun joinWithSeparator(vararg items: String): String {
        var itemList = Constants.EMPTY_STRING
        for (item in items) {
            if (item.isNotEmpty()) {
                itemList = if (TextUtils.isEmpty(itemList)) {
                    item
                } else {
                    resources.getString(R.string.exo_item_list, itemList, item)
                }
            }
        }
        return itemList
    }

    /**
     * Generate Track name with Quality and Size
     *
     * @author Ashik
     * @since 20/05/2020
     * */
    private fun generateAlignedTrackName(leftString: String, rightString: String): SpannedString {

        val finalString = "$leftString  $rightString"
        return try {
            buildSpannedString {
                append(leftString)
                append(" ($rightString)")
                /*append(rightString).setSpan(
                    AlignmentSpan.Standard(Layout.Alignment.ALIGN_OPPOSITE),
                    leftString.length + 1,
                    finalString.length - 2,
                    Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                )*/
            }
        } catch (e: IndexOutOfBoundsException) {
            buildSpannedString { append(finalString) }
        }
    }
}
