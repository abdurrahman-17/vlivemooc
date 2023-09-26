package com.mobiotics.vlive.android.tracker

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.enrichtv.android.player.models.content.Content

import com.google.android.exoplayer2.analytics.AnalyticsListener
import com.enrichtv.android.tracker.EmptyTracker
import java.util.Date

/**
 * Class which contains all the tracker implementations initialized in the list.
 *
 * This class extends the [Tracker] class.
 *
 * When the abstract function in the tracker class is called, in-turn it will call all the trackers initialized.
 *
 * @property list [List] of [Tracker]
 * @author Mohan
 * @since 5 Aug 2020
 */
class AnalyticsTracker private constructor(private val list: List<Tracker>) : Tracker {

    override fun trackScreen(activity: AppCompatActivity?, screenName: String) {
        list.forEach { it.trackScreen(activity, screenName) }
    }

    override fun trackScreen(fragment: Fragment?, screenName: String) {
        list.forEach { it.trackScreen(fragment, screenName) }
    }


    override fun signUpEvent(
        signUpMode: String,
        status: String,
        errorReason: String?,
        email: String?,
        mobileNo: String?,
        name: String?,
        city: String?,
        region: String?,
        age: String?,
        gender: String?,
        code: String?
    ) {
        list.forEach {
            it.signUpEvent(
                signUpMode,
                status,
                errorReason,
                email,
                mobileNo,
                name,
                city,
                region,
                age,
                gender,
                code
            )
        }
    }



    override fun searchEvent(query: String) {
        list.forEach { it.searchEvent(query) }
    }

    override fun shareEvent(content: Content?, medium: String) {
        list.forEach { it.shareEvent(content, medium) }
    }

    override fun playStartedEvent(
        content: Content?,
        playbackType: PlaybackType,
        startPosition: Long
    ) {
        list.forEach { it.playStartedEvent(content, playbackType, startPosition) }
    }

    override fun playWatchedEvent(
        content: Content?,
        playbackType: PlaybackType,
        startPosition: Long,
        watchDuration: Long,
        watchTime: Long,
        isFinished: Boolean,
        source: String,
        country: String,
        dayOfWeek: String,
        timeOfDay: String,
        audioLanguage: String,
        subtitleLanguage: String,
        platform: String,
        platformType: String
    ) {
        list.forEach {
            it.playWatchedEvent(
                content,
                playbackType,
                startPosition,
                watchDuration,
                watchTime,
                isFinished,
                source,
                country,
                dayOfWeek,
                timeOfDay,
                audioLanguage,
                subtitleLanguage,
                platform,
                platformType
            )
        }
    }

    override fun downloadInitiated(content: Content?) {
        list.forEach { it.downloadInitiated(content) }
    }

    override fun downloadCompleted(content: Content?) {
        list.forEach { it.downloadCompleted(content) }
    }



    override fun subscriptionUpdated(
        objectId: String?,
        planName: String?,
        status: String,
        startDate: Date?,
        endDate: Date?,
        type: String
    ) {
        list.forEach {
            it.subscriptionUpdated(
                objectId,
                planName,
                status,
                startDate,
                endDate,
                type
            )
        }
    }

    override fun paymentCompleted(
        freeTrial: Boolean?,
        paymentMode: String?,
        startDate: Date?,
        endDate: Date?,
        transactionId: String?,
        amount: Int?,
        currencyCode: String?,
        paymentId: String?,
        promoCode: String?,
        discountAmount: Double?,
        planId: String?,
        planName: String?,
        objectId: String?,
        objectName: String?,
        objectQuality: String?
    ) {
        list.forEach {
            it.paymentCompleted(
                freeTrial,
                paymentMode,
                startDate,
                endDate,
                transactionId,
                amount,
                currencyCode,
                paymentId,
                promoCode,
                discountAmount,
                planId,
                planName,
                objectId,
                objectName,
                objectQuality
            )
        }
    }

    override fun paymentFailed(
        paymentMode: String,
        amount: Int,
        currencyCode: String,
        paymentId: String,
        promoCode: String,
        discountAmount: Int,
        freeTrial: Boolean,
        planId: String?,
        planName: String?,
        objectId: String?,
        objectName: String?,
        objectQuality: String?,
        errorReason: String?,
        errorType: String?
    ) {
        list.forEach {
            it.paymentFailed(
                paymentMode,
                amount,
                currencyCode,
                paymentId,
                promoCode,
                discountAmount,
                freeTrial,
                planId,
                planName,
                objectId,
                objectName,
                objectQuality,
                errorReason,
                errorType
            )
        }
    }

    override fun userLoginStatus(
        loginMode: String?,
        status: String?,
        errorReason: String?,
        errorCode: String?,
        email: String?,
        mobileNumber: String?
    ) {
        list.forEach { it.userLoginStatus(loginMode, status, errorReason, email, mobileNumber) }
    }

    override fun createProfile(
        profileId: String,
        isKid: Boolean,
        hasPin: Boolean,
        age: String?,
        gender: String?,
        picture: String?
    ) {
        list.forEach { it.createProfile(profileId, isKid, hasPin, age, gender, picture) }
    }

    override fun logout() {
        list.forEach { it.logout() }
    }

    override fun switchProfile(profileId: String?) {
        list.forEach { it.switchProfile(profileId) }
    }

    override fun deleteProfile(profileId: String?) {
        list.forEach { it.deleteProfile(profileId) }
    }

    override fun pageView(screenName: String, actualScreenName: String?) {
        list.forEach { it.pageView(screenName, actualScreenName) }
    }

    override fun action(
        actionName: String?,
        contentID: String?,
        contentTitle: String?,
        contentType: String?,
        contentCategory: String?,
        genre: String?,
        medium: String?,
        rating: String?,
        packageID: String?,
        mode: String?,
        quality: String?
    ) {
        list.forEach {
            it.action(
                actionName,
                contentID,
                contentTitle,
                contentType,
                contentCategory,
                genre,
                medium,
                rating,
                packageID,
                mode,
                quality
            )
        }
    }

    override fun shareApp(medium: String) {
        list.forEach { it.shareApp(medium) }
    }

    override fun rated(content: Content?, rating: String) {
        list.forEach { it.rated(content, rating) }
    }

    override fun drmSession(
        eventName: String,
        eventTime: AnalyticsListener.EventTime,
        error: Exception?
    ) {
        list.forEach { it.drmSession(eventName, eventTime, error) }
    }

    override fun appStop(time: Long) {
        list.forEach { it.appStop(time) }
    }

    override fun resetPasswordEvent(
        status: String?,
        email: String?,
        mobile: String?,
        errorMessage: String?,
        errorCode: String?
    ) {
        list.forEach { it.resetPasswordEvent(status, email, mobile, errorMessage, errorCode) }
    }

    override fun changePasswordEvent(
        status: String?,
        email: String?,
        errorMessage: String?,
        errorCode: String?
    ) {
        list.forEach { it.resetPasswordEvent(status, email, errorMessage, errorCode) }
    }

    override fun appSettingsEvent(
        wifiSetting: Boolean?,
        themeSetting: String?,
        languageSetting: String?,
        qualitySetting: String?
    ) {
        list.forEach {
            it.appSettingsEvent(
                wifiSetting,
                themeSetting,
                languageSetting,
                qualitySetting
            )
        }
    }

    override fun enableDeviceEvent(
        deviceid: String?,
        enable: Boolean?,
        status: String?,
        deviceType: String?,
        deviceOS: String?
    ) {
        list.forEach {
            it.enableDeviceEvent(
                deviceid,
                enable,
                status,
                deviceType,
                deviceOS
            )
        }
    }

    override fun browsingContentEvent(fromScreen: String?, toScreen: String?) {
        list.forEach { it.browsingContentEvent(fromScreen, toScreen) }
    }

    override fun contentDetailsEvent(
        fromScreen: String?,
        fromSection: String?,
        contentTitle: String?,
        contentID: String?,
        contentType: String?,
        genre: String?,
        contentCategory: String?,
        seasonNumber: String?,
        episodeNumber: String?,
        recommendationID: String?,
        impressionList: String?
    ) {
        list.forEach {
            it.contentDetailsEvent(
                fromScreen,
                fromSection,
                contentTitle,
                contentID,
                contentType,
                genre,
                contentCategory,
                seasonNumber,
                episodeNumber,
                recommendationID,
                impressionList
            )
        }
    }

    override fun contentViewEvents(
        status: String?,
        contentID: String?,
        contentType: String?,
        packageID: String?,
        contentTitle: String?,
        genre: String?,
        contentCategory: String?,
        seasonNumber: String?,
        episodeNumber: String?,
        playbackMode: String?,
        playStartPosition: String?,
        playDuration: String?,
        contentDuration: String?,
        resumedFromPrevSession: String?,
        referredFrom: String?,
        percentageWatched: String?,
        recommendationID: String?,
        impressionList: String?,
        errorMessage: String?,
        errorCode: String?
    ) {
        list.forEach {
            it.contentViewEvents(
                status,
                contentID,
                contentType,
                packageID,
                contentTitle,
                genre,
                contentCategory,
                seasonNumber,
                episodeNumber,
                playbackMode,
                playStartPosition,
                playDuration,
                contentDuration,
                resumedFromPrevSession,
                referredFrom,
                percentageWatched,
                recommendationID,
                impressionList,
                errorMessage,
                errorCode
            )
        }
    }

    override fun trailerViewEvents(
        status: String?,
        contentID: String?,
        contentTitle: String?,
        genre: String?,
        contentCategory: String?,
        quality: String?,
        percentageWatched: String?,
        errorMessage: String?,
        errorCode: String?
    ) {
        list.forEach {
            it.trailerViewEvents(
                status,
                contentID,
                contentTitle,
                genre,
                contentCategory,
                quality,
                percentageWatched,
                errorMessage,
                errorCode
            )
        }
    }

    override fun paymentEvents(
        status: String?,
        paymentProvider: String?,
        paymentmode: String?,
        transactiontype: String?,
        typeid: String?,
        errorMessage: String?,
        errorCode: String?,
        subscriberID: String?,
        planType: String?,
        subscriptionMode: String?,
        subscriptionType: String?,
        fromPlanID: String?,
        planID: String?,
        planName: String?,
        couponCode: String?,
        couponType: String?,
        paymentID: String?,
        amount: String?,
        discountedAmount: String?,
        currency: String?,
        expiryDate: String?,
        objectID: String?,
        objectName: String?,
        objectType: String?,
        purchaseType: String?,
        quality: String?
    ) {
        list.forEach {
            it.paymentEvents(
                status,
                paymentProvider,
                paymentmode,
                transactiontype,
                typeid,
                errorMessage,
                errorCode,
                subscriberID,
                planType,
                subscriptionMode,
                subscriptionType,
                fromPlanID,
                planID,
                planName,
                couponCode,
                couponType,
                paymentID,
                amount,
                discountedAmount,
                currency,
                expiryDate,
                objectID,
                objectName,
                objectType,
                purchaseType,
                quality
            )
        }
    }

    override fun appActionEvents(status: String?, rating: String?) {
        list.forEach {
            it.appActionEvents(
                status, rating
            )
        }
    }

    override fun playerPerformanceEvents(
        status: String?,
        loadTime: String?,
        contentID: String?,
        packageID: String?,
        contentTitle: String?,
        contentCategory: String?,
        bandwidthValue: String?,
        frameDropoutCount: String?,
        syncStatus: String?,
        direction: String?,
        trackId: String?,
        language: String?
    ) {
        list.forEach {
            it.playerPerformanceEvents(
                status,
                loadTime,
                contentID,
                packageID,
                contentTitle,
                contentCategory,
                bandwidthValue,
                frameDropoutCount,
                syncStatus,
                direction,
                trackId,
                language
            )
        }
    }

    override fun apiTokenEvent(
        status: String?,
        errorMessage: String?,
        errorCode: String?
    ) {
        list.forEach {
            it.apiTokenEvent(
                status,
                errorMessage,
                errorCode
            )

        }
    }

    override fun searchEvent(
        fromScreen: String?,
        searchType: String?,
        searchSource: String?,
        keyword: String?,
        searchCount: String?,
        nextAction: String?
    ) {
        list.forEach {
            it.searchEvent(
                fromScreen,
                searchType,
                searchSource,
                keyword,
                searchCount,
                nextAction
            )
        }
    }

    /**
     * Builder for the [AnalyticsTracker] class.
     */
    class Builder {

        private val list: MutableList<Tracker> = mutableListOf()

        /**
         * Add a [Tracker] implementation object to the list
         *
         * @param tracker Instance of a class which extends the [Tracker] interface
         * @return [Builder]
         */
        fun add(tracker: Tracker): Builder {
            if (tracker !is AnalyticsTracker && tracker !is EmptyTracker)
                this.list.add(tracker)
            return this
        }

        /**
         * Creates new instance of the [AnalyticsTracker] class & returns.
         *
         * @return [AnalyticsTracker]
         */
        fun build(): AnalyticsTracker {
            return AnalyticsTracker(list)
        }
    }

}
