package com.enrichtv.android.player.models.content

import android.os.Parcelable
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize

@Parcelize
@Keep
class CastNew(
    @SerializedName("castncrewid") var castncrewid: String? = null,
    @SerializedName("role") var role: ArrayList<String> = arrayListOf(),
    @SerializedName("name") var name: String? = null,
    @SerializedName("description") var description: String? = null,
    @SerializedName("profilepic") var profilepic: String? = null
) : Parcelable