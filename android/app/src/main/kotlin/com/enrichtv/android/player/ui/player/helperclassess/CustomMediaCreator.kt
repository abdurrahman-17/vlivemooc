package com.enrichtv.android.ui.player.helperclassess

import android.net.Uri
import com.enrichtv.android.player.models.content.Content
import com.enrichtv.android.player.models.content.Orientation
import com.enrichtv.android.player.models.content.poster
import com.enrichtv.android.player.models.content.ObjectType

import com.mobiotics.player.core.media.Media
import com.mobiotics.player.core.media.MediaCreator

class CustomMediaCreator : MediaCreator<Content> {

    override fun create(value: Content): Media<Content> {
        return Media<Content>(
            value.objectid,
            value.title,
            value.shortDescription,
            value.poster(Orientation.LANDSCAPE),
            value.contentStream?.streamfilename?.let { Uri.parse(it) },
//            adsUri = if (Utils.showAds(value)) Uri.parse(adsSampleUrl)  else null,
            isLive = value.objectType == ObjectType.CHANEL
        ).apply { this.t = value }
    }

    override fun create(list: List<Content>): MutableList<Media<Content>> {
        return list.map { create(it) }.toMutableList()
    }

}