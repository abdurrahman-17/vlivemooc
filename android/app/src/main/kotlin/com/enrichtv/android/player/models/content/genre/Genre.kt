package com.enrichtv.android.player.models.content.genre


import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.COUNT
import com.enrichtv.android.player.ApiConstant.GENRE
import com.google.gson.annotations.SerializedName

@Keep
data class Genre(
    @SerializedName(COUNT)
    val count: String?,
    @SerializedName(GENRE)
    val genre: String?
)
