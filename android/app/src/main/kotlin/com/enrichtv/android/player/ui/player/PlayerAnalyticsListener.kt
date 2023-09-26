package com.enrichtv.android.ui.player

import com.enrichtv.android.player.models.content.Content
import com.google.android.exoplayer2.analytics.AnalyticsListener
import com.google.android.exoplayer2.source.MediaSourceEventListener
import com.mobiotics.core.extensions.isNotNull
import com.mobiotics.vlive.android.tracker.AnalyticsProvider
import com.enrichtv.android.tracker.TrackerConstant.PLAY_BW_CHANGE
import com.enrichtv.android.tracker.TrackerConstant.PLAY_FRAME_DROP
import com.enrichtv.android.tracker.TrackerConstant.PLAY_LOAD_TIME


/**
 * Exo-Player Analytics listener.
 *
 * @property tracker [AnalyticsTracker] instance.
 */
class PlayerAnalyticsListener : AnalyticsListener {
    private var content: Content? = null
    private var seekProcessListener: ((AnalyticsListener.EventTime) -> Unit)? = null

    override fun onBandwidthEstimate(
        eventTime: AnalyticsListener.EventTime,
        totalLoadTimeMs: Int,
        totalBytesLoaded: Long,
        bitrateEstimate: Long
    ) {
        super.onBandwidthEstimate(eventTime, totalLoadTimeMs, totalBytesLoaded, bitrateEstimate)
        if (content.isNotNull())
            AnalyticsProvider.getInstance()?.getTracker()
                ?.playerPerformanceEvents(
                    PLAY_BW_CHANGE,
                    bandwidthValue = totalBytesLoaded.toString(),
                    contentID = content?.objectid,
                    packageID = content?.contentStream?.packageid,
                    contentTitle = content?.title,
                    contentCategory = content?.category?.name
                )
    }

    override fun onDrmKeysLoaded(eventTime: AnalyticsListener.EventTime) {
        super.onDrmKeysLoaded(eventTime)
        AnalyticsProvider.getInstance()?.getTracker()?.drmSession("onDrmKeysLoaded", eventTime)
    }

    override fun onDrmKeysRemoved(eventTime: AnalyticsListener.EventTime) {
        super.onDrmKeysRemoved(eventTime)
        AnalyticsProvider.getInstance()?.getTracker()?.drmSession("onDrmKeysRemoved", eventTime)
    }

    override fun onDrmKeysRestored(eventTime: AnalyticsListener.EventTime) {
        super.onDrmKeysRestored(eventTime)
        AnalyticsProvider.getInstance()?.getTracker()?.drmSession("onDrmKeysRestored", eventTime)
    }

    override fun onDrmSessionAcquired(eventTime: AnalyticsListener.EventTime) {
        super.onDrmSessionAcquired(eventTime)
        AnalyticsProvider.getInstance()?.getTracker()?.drmSession("onDrmSessionAcquired", eventTime)
    }

    override fun onDrmSessionManagerError(
        eventTime: AnalyticsListener.EventTime,
        error: Exception
    ) {
        super.onDrmSessionManagerError(eventTime, error)
        AnalyticsProvider.getInstance()?.getTracker()
            ?.drmSession("onDrmSessionManagerError", eventTime, error)
    }

    override fun onDrmSessionReleased(eventTime: AnalyticsListener.EventTime) {
        super.onDrmSessionReleased(eventTime)
        AnalyticsProvider.getInstance()?.getTracker()?.drmSession("onDrmSessionReleased", eventTime)
    }

    override fun onDroppedVideoFrames(
        eventTime: AnalyticsListener.EventTime,
        droppedFrames: Int,
        elapsedMs: Long
    ) {
        super.onDroppedVideoFrames(eventTime, droppedFrames, elapsedMs)
        if (content.isNotNull())
            AnalyticsProvider.getInstance()?.getTracker()
                ?.playerPerformanceEvents(
                    PLAY_FRAME_DROP,
                    frameDropoutCount = droppedFrames.toString(),
                    contentID = content?.objectid,
                    packageID = content?.contentStream?.packageid,
                    contentTitle = content?.title,
                    contentCategory = content?.category?.name
                )
    }

    override fun onLoadCompleted(
        eventTime: AnalyticsListener.EventTime,
        loadEventInfo: MediaSourceEventListener.LoadEventInfo,
        mediaLoadData: MediaSourceEventListener.MediaLoadData
    ) {
        super.onLoadCompleted(eventTime, loadEventInfo, mediaLoadData)
        if (content.isNotNull())
            AnalyticsProvider.getInstance()?.getTracker()
                ?.playerPerformanceEvents(
                    PLAY_LOAD_TIME,
                    loadTime = eventTime.totalBufferedDurationMs.toString(),
                    contentID = content?.objectid,
                    packageID = content?.contentStream?.packageid,
                    contentTitle = content?.title,
                    contentCategory = content?.category?.name
                )
    }

    /**
     * Updates the Content
     */
    fun updateContent(content: Content?) {
        this.content = content
    }

    override fun onSeekProcessed(eventTime: AnalyticsListener.EventTime) {
        super.onSeekProcessed(eventTime)
        seekProcessListener?.invoke(eventTime)
    }

    /**
     * Removes the seek process listener attached.
     */
    fun removeSeekProcessListener() {
        this.seekProcessListener = null
    }

    /**
     * Assigns the seek process listener
     *
     * @param listener
     */
    fun setSeekProcessListener(listener: (AnalyticsListener.EventTime) -> Unit) {
        this.seekProcessListener = listener
    }
}
