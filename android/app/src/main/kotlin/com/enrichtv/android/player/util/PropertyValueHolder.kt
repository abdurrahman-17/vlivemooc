package com.enrichtv.android.util

import android.animation.PropertyValuesHolder
import android.view.View

/***
 * Lazy initialization of [PropertyValuesHolder] for animation
 *
 * @author Ashik
 * @since 15/06/2020
 */

object PropertyValueHolder {

    /**
     * View Show animation properties.
     */
    @Suppress("MagicNumber")
    object Show {
        val scaleX: PropertyValuesHolder by lazy { PropertyValuesHolder.ofFloat(View.SCALE_X, 0.5f, 1f) }
        val scaleY: PropertyValuesHolder by lazy { PropertyValuesHolder.ofFloat(View.SCALE_Y, 0.5f, 1f) }
        val alpha: PropertyValuesHolder by lazy { PropertyValuesHolder.ofFloat(View.ALPHA, 0f, 1f) }
    }

    /**
     * View Hide animation properties.
     */
    @Suppress("MagicNumber")
    object Hide {
        val scaleX: PropertyValuesHolder by lazy { PropertyValuesHolder.ofFloat(View.SCALE_X, 1f, 0f) }
        val scaleY: PropertyValuesHolder by lazy { PropertyValuesHolder.ofFloat(View.SCALE_Y, 1f, 0f) }
        val alpha: PropertyValuesHolder by lazy { PropertyValuesHolder.ofFloat(View.ALPHA, 1f, 0f) }
    }
}
