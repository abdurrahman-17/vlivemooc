package com.mobiotics.vlive.android.tracker

import com.enrichtv.android.util.SingletonHolder


/**
 * Provider for the [Tracker] implementation. Returns the singleton object.
 *
 * @property tracker [AnalyticsTracker] instance
 * @author Mohan
 * @since 5 Aug 2020
 */
class AnalyticsProvider private constructor(private val tracker: AnalyticsTracker) {

    companion object : SingletonHolder<AnalyticsProvider, AnalyticsTracker>(::AnalyticsProvider)

    /**
     * Returns the tracker object
     *
     * @return [Tracker]
     */
    fun getTracker(): Tracker {
        return tracker
    }

}