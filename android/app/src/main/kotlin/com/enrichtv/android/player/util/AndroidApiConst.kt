/**
 * This class is used use check the OS version of mobile
 **/
package com.enrichtv.android.util

import android.os.Build

/**
 * @author Ratnesh Kumar Ratan
 * @since 20/4/20
 **/
object AndroidApiConst {
    val IS_LOLLIPOP_AND_ABOVE = Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP
    val IS_MARSHMALLOW_AND_ABOVE = Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
    val IS_NOUGAT_AND_ABOVE = Build.VERSION.SDK_INT >= Build.VERSION_CODES.N

}
