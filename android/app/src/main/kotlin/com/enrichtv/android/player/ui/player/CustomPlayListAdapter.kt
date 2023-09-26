/** This is an adapter call use for playlist **/
package com.enrichtv.android.ui.player

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView

import com.enrichtv.android.player.models.content.Content
import com.enrichtv.android.R
import com.mobiotics.core.convertToHourMinute
import com.mobiotics.player.core.getPlayListItemWidth
import com.mobiotics.player.core.media.Media
import com.mobiotics.player.core.media.Provider
import com.mobiotics.player.core.ui.playlist.PlayListAdapter
import com.enrichtv.android.player.Constants
import com.enrichtv.android.player.GetTagLocal
import com.enrichtv.android.databinding.ItemPlaylistBinding
import com.enrichtv.android.util.GlideApp
import com.enrichtv.android.util.LocaleHelper
import com.enrichtv.android.util.hide
import com.enrichtv.android.util.show


/**
 *
 * @author Bhaskar
 * Created on 1/4/23 .
 */
class CustomPlayListAdapter(
    private val provider: Provider<Content>,
    showPlaying: Boolean,
    private val getTagLocal: GetTagLocal
) :
    PlayListAdapter<Content, CustomPlayListAdapter.PlayListViewHolder>(provider, showPlaying) {

    init {
        // crashLog(CustomPlayListAdapter::class)
    }

    private var viewHolder: CustomPlayListAdapter.PlayListViewHolder? = null
    var pos: Int = 0
    private var isSeasonListing: Boolean = false

    /**
     * check whether the playlist content is season / not
     * if(true) show playing content also
     * else hide playing content
     * */
    fun isSeasonListing(isSeasonListing: Boolean) {
        this.isSeasonListing = isSeasonListing
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PlayListViewHolder {

        val binding =
            ItemPlaylistBinding.inflate(LayoutInflater.from(parent.context), parent, false)

        return PlayListViewHolder(
            binding
        )
    }

    override fun onBindViewHolder(holder: PlayListViewHolder, position: Int) {
        this.viewHolder = holder
        this.pos = position
        super.onBindViewHolder(holder, position)
    }

    override fun bind(view: View, media: Media<Content>) {
        val itemPlaylistBinding = viewHolder?.itemPlaylistBinding
        if (isSeasonListing) {
            viewHolder?.itemView?.layoutParams?.width =
                viewHolder?.itemView?.context?.getPlayListItemWidth(Constants.PLAYLIST_ITEM_WIDTH_IN_PERCENT)
            viewHolder?.itemView?.layoutParams?.height = ViewGroup.LayoutParams.WRAP_CONTENT
        }


        with(view) {
            itemPlaylistBinding?.textTitle?.text =
                if (isSeasonListing) "E${pos + 1}: ${media.title}" else media.title
            itemPlaylistBinding?.textDescription?.text =
                media.t?.duration?.toString()?.let { convertToHourMinute(it) }
            itemPlaylistBinding?.textNowPlaying?.text =
                LocaleHelper.switchLocale(context)?.getString(R.string.now_playing)
            itemPlaylistBinding?.textNowPlaying?.isVisible = provider.getMedia()?.id == media.id
            itemPlaylistBinding?.imagePoster?.let {
                GlideApp.with(this).load(media.posterLink)/*.portrait()*/
                    .into(itemPlaylistBinding?.imagePoster)
            }
            if (!media.t?.objectTag.isNullOrEmpty()) {
                viewHolder?.itemPlaylistBinding?.textTagNew?.text =
                    getTagLocal.getTagName(media.t?.objectTag)
                viewHolder?.itemPlaylistBinding?.textTagNew.show()
            } else
                itemPlaylistBinding?.textTagNew.hide()
        }
    }

    /**
     * Declare View he;d
     * */
    inner class PlayListViewHolder(val itemPlaylistBinding: ItemPlaylistBinding) :
        RecyclerView.ViewHolder(itemPlaylistBinding.root) {

    }

}
