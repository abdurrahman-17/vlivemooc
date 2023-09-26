package com.enrichtv.android.player.models.content

import android.os.Parcelable
import androidx.annotation.Keep
import kotlinx.android.parcel.Parcelize


@Parcelize
@Keep
data class MetaContent(
    var metatitle: String? = null,
    var metadescription: String? = null
) : Parcelable
