package com.enrichtv.android.player.models.content

import android.os.Parcelable
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class CastCrew(

    @SerializedName("cast" ) var cast : ArrayList<CastNew> = arrayListOf(),
    @SerializedName("crew" ) var crew : ArrayList<CrewNew> = arrayListOf()
) : Parcelable
