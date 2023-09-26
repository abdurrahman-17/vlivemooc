package com.enrichtv.android.player.models.content.genre

import androidx.annotation.Keep
import com.enrichtv.android.player.models.content.Content

/**
 * @author Ratnesh Kumar Ratan
 * @since 7/8/20
 **/
@Keep
class ContentList(
    val totalcount: Int,
    val data: List<Content> = emptyList()
)
