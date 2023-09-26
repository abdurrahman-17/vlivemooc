package com.enrichtv.android.player.models.content.genre


import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.CATEGORY
import com.enrichtv.android.player.ApiConstant.GENRE_LIST
import com.google.gson.annotations.SerializedName

@Keep
data class GenreContract(
    @SerializedName(CATEGORY)
    val category: String? = null,
    @SerializedName(GENRE_LIST)
    val genreList: List<Genre?>?
)
