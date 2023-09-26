/**
 * Adapter class handle season
 * */
package com.enrichtv.android.ui.player

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckedTextView
import android.widget.TextView
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.enrichtv.android.player.models.content.Content
import com.enrichtv.android.R

import com.enrichtv.android.adapters.diff.ContentDiff

/**
 * @author Ashik
 * Created on 16/6/20 .
 */
class SeasonAdapter : ListAdapter<Content, SeasonAdapter.SeasonViewHolder>(ContentDiff()) {

  /*  init {
        crashLog(SeasonAdapter::class)
    }*/

    //Season item Click listener
    private var seasonClickListener: ((String) -> Unit)? = null

    private var currentCheckedView: CheckedTextView? = null

    /**
     * Method for season click listener
     * @param listener click listener callback
     * */
    fun onSeasonClick(listener: (String) -> Unit) {
        this.seasonClickListener = listener
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SeasonViewHolder {
        return SeasonViewHolder(
            LayoutInflater.from(parent.context)
                .inflate(R.layout.item_play_list_season, parent, false)
        )
    }

    override fun onBindViewHolder(holder: SeasonViewHolder, position: Int) {
        holder.bind()
    }

    inner class SeasonViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind() {
            val position = adapterPosition
            if (position != RecyclerView.NO_POSITION) {
                with(itemView) {
                    val checkBox = this as? CheckedTextView
                    checkBox?.isChecked = getItem(position).isChecked
                    itemView as CheckedTextView
                    val season = getItem(position)
                    itemView.findViewById<TextView>(R.id.text_item_season_name).text = season.title
                    setOnClickListener {
                        currentList.forEach { it.isChecked = false }
                        season.isChecked = true
                        if (null != currentCheckedView && this != currentCheckedView)
                            currentCheckedView?.isChecked = false
                        currentCheckedView = this as CheckedTextView
                        season.seasonNum.let { it1 -> seasonClickListener?.invoke(it1.toString()) }
                    }
                }
            }
        }
    }
}
