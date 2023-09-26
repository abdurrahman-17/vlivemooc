package com.enrichtv.android.player.models.content

import android.provider.MediaStore
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.COUNT
import com.enrichtv.android.player.ApiConstant.GENRE
import com.enrichtv.android.player.ApiConstant.GENRE_LIST
import com.google.gson.annotations.SerializedName

@Keep
data class Genre(
    @SerializedName(GENRE) val title: String,
    @SerializedName(COUNT) val count: Int = 0,
    @SerializedName(GENRE_LIST) val genres: List<Genre>? = null,
    var category: String? = null,
    var list: List<MediaStore.Video>? = null
)
