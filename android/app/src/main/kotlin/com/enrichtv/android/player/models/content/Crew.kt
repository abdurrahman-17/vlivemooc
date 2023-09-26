package com.enrichtv.android.player.models.content


import android.os.Parcelable
import androidx.annotation.Keep
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
data class Crew(
    val role: String?,
    val crew: String?
) : Parcelable
