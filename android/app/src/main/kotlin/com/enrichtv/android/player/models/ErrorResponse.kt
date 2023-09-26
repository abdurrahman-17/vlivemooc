package com.enrichtv.android.models

import com.google.gson.annotations.SerializedName

/**
 * To capture errors coming in 200 - 300 series responses
 *
 * @constructor Create empty Error response
 */
open class ErrorResponse {
    /**
     * Error code
     */
    @SerializedName("errorcode", alternate = ["error"])
    val errorCode: Int? = null

    /**
     * Reason
     */
    @SerializedName("reason")
    val reason: String = ""
}
