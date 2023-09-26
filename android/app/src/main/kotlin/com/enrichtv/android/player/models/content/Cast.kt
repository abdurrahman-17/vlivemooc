package com.enrichtv.android.player.models.content

import android.os.Parcelable
import androidx.annotation.Keep
import kotlinx.android.parcel.Parcelize


/**
 * @author Ashik
 * Created on 8/8/20 .
 */
@Parcelize
@Keep
data class Cast(
    val role: String?,
    val cast: String?
) : Parcelable
