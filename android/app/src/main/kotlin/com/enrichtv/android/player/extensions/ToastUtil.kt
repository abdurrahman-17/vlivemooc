package com.enrichtv.android.extensions

import android.content.Context
import android.widget.Toast
import androidx.annotation.StringRes

/**
 * Util file for toast message.
 */
internal object ToastUtil {

    @JvmStatic
    internal fun toast(context: Context, message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }

    @JvmStatic
    internal fun toast(context: Context, @StringRes message: Int) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }
}
