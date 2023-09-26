/** This class provide Track name provider **/
package com.enrichtv.android.ui.player.exo

import android.content.Context
import android.content.res.Resources
import android.text.SpannableStringBuilder
import android.text.TextUtils
import com.enrichtv.android.R

import com.google.android.exoplayer2.C
import com.google.android.exoplayer2.Format
import com.google.android.exoplayer2.util.MimeTypes
import com.mobiotics.player.exo.track.TrackNameProvider
import com.enrichtv.android.player.Constants
import com.enrichtv.android.player.Constants.VIDEO_QUALITY_1080
import com.enrichtv.android.player.Constants.VIDEO_QUALITY_720
import com.enrichtv.android.util.AndroidApiConst
import com.enrichtv.android.util.LocaleHelper

import java.util.*

/**
 * @author Ratnesh Kumar Ratan
 * @since 04/04/2020
 *
 * @modifier Ashik
 * @since 15/07/2020
 */
class PlayerTrackNameProvider(private val context: Context) : TrackNameProvider {

    private val resources: Resources = context.resources

    override fun getTrackName(format: Format): CharSequence {
        val trackName: CharSequence
        val trackType = inferPrimaryTrackType(format)
        trackName = when (trackType) {
            C.TRACK_TYPE_VIDEO -> buildResolutionString(format)
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
            if (height == VIDEO_QUALITY_720 || height == VIDEO_QUALITY_1080) {
                val qualityVar = resources.getString(R.string.exo_hd_format, height.toString())
                val spr = SpannableStringBuilder(qualityVar)
                spr
            } else
                height.toString() + "p"
        }
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
            if (AndroidApiConst.IS_LOLLIPOP_AND_ABOVE) Locale.forLanguageTag(language) else Locale(
                language
            )
        return locale.getDisplayName(LocaleHelper.getLocale(context))
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
}
