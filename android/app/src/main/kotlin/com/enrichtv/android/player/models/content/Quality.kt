/**
 * Model class for Video quality
 * */
package com.enrichtv.android.player.models.content

import androidx.annotation.Keep
import androidx.annotation.StringRes


/**
 * @author Ashik
 * Created on 20/6/20 .
 */
@Keep
data class Quality(@StringRes val name: Int, val description: String)
