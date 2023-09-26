/**
 * This class will returns DiffUtil of type Content
 * */
package com.enrichtv.android.adapters.diff

import androidx.recyclerview.widget.DiffUtil
import com.enrichtv.android.player.models.content.Content

/**
 * @author Ratnesh Kumar Ratan
 * @since 17/03/2020
 * */

class ContentDiff : DiffUtil.ItemCallback<Content>() {
    override fun areItemsTheSame(oldItem: Content, newItem: Content): Boolean {
        return oldItem.objectid == newItem.objectid
    }

    override fun areContentsTheSame(oldItem: Content, newItem: Content): Boolean {
        return oldItem == newItem
    }
}


