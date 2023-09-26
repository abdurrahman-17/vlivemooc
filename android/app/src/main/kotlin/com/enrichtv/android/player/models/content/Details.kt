package com.enrichtv.android.player.models.content


import android.os.Parcelable
import androidx.annotation.Keep
import com.enrichtv.android.player.ApiConstant.CAST
import com.enrichtv.android.player.ApiConstant.CREW
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class Details(
    @SerializedName(CAST)
    val cast: List<Cast>?,
    @SerializedName(CREW)
    val crew: List<Crew>?
) : Parcelable
