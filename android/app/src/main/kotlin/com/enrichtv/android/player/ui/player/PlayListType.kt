/**
 * Sealed class for player type
 * */
package com.enrichtv.android.ui.player


/**
 * @author Ashik
 * Created on 18/7/20 .
 */
sealed class PlayListType {
    object PlayListNormal : PlayListType()
    object PlayListSeries : PlayListType()
    object PlayListOffline : PlayListType()
}
