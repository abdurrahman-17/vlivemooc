package com.enrichtv.android.player.ui.player.cast

import android.view.Menu
import com.google.android.gms.cast.framework.CastButtonFactory
import com.google.android.gms.cast.framework.media.widget.ExpandedControllerActivity
import com.enrichtv.android.R

/**
 * @author Ashik
 * Created on 12/2/20 .
 */
class ExpandedCastControlActivity :ExpandedControllerActivity() {

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu_cast, menu)
        CastButtonFactory.setUpMediaRouteButton(this, menu!!, R.id.media_route_menu_item)
        return true    }
}
