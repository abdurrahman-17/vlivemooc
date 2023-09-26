/**
 * Class provide deeplink action
 **/

package com.enrichtv.android.player.models.content

import android.os.Parcelable
import androidx.annotation.Keep
import kotlinx.android.parcel.Parcelize

/**
 * @author Ratnesh Kumar Ratan
 * @since 1/9/20
 **/

@Parcelize
@Keep
data class DeepLinkAction(
    val play: Boolean? = null,
    val trailerId: String?= null,
    val share : Boolean? = null,
    val purchase : Boolean? = null,
    val couponId : String? = null
): Parcelable
