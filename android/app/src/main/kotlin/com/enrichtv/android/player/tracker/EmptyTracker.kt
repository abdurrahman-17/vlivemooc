package com.enrichtv.android.tracker

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.enrichtv.android.player.models.content.Content

import com.google.android.exoplayer2.analytics.AnalyticsListener
import com.mobiotics.vlive.android.tracker.PlaybackType
import com.mobiotics.vlive.android.tracker.Tracker
import java.util.*

/**
 * Empty class implementation of the [Tracker] class
 *
 * @author Mohan
 * @since 5 Aug 2020
 */
open class EmptyTracker : Tracker {

    override fun downloadCompleted(content: Content?) {
        // do nothing
    }

    override fun downloadInitiated(content: Content?) {
        // do nothing
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
        // do nothing
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
        // do nothing
    }



    override fun playStartedEvent(
        content: Content?,
        playbackType: PlaybackType,
        startPosition: Long
    ) {
        // do nothing
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
        // do nothing
    }


    override fun searchEvent(query: String) {
        // do nothing
    }

    override fun shareEvent(content: Content?, medium: String) {
        // do nothing
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
        // do nothing
    }

    override fun subscriptionUpdated(
        objectId: String?,
        planName: String?,
        status: String,
        startDate: Date?,
        endDate: Date?,
        type: String
    ) {
        // do nothing
    }

    override fun trackScreen(activity: AppCompatActivity?, screenName: String) {
        // do nothing
    }

    override fun trackScreen(fragment: Fragment?, screenName: String) {
        // do nothing
    }

    override fun userLoginStatus(
        loginMode: String?,
        status: String?,
        errorReason: String?,
        errorCode: String?,
        email: String?,
        mobileNumber: String?
    ) {
        // do nothing
    }

    override fun createProfile(
        profileId: String,
        isKid: Boolean,
        hasPin: Boolean,
        age: String?,
        gender: String?,
        picture: String?
    ) {
        // do nothing
    }

    override fun logout() {
        // do nothing
    }

    override fun switchProfile(profileId: String?) {
        // do nothing
    }

    override fun deleteProfile(profileId: String?) {
        // do nothing
    }

    override fun pageView(screenName: String, actualScreenName: String?) {
        // do nothing
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
        // do nothing
    }

    override fun shareApp(medium: String) {
        // do nothing
    }

    override fun rated(content: Content?, rating: String) {
        // do nothing
    }

    override fun drmSession(
        eventName: String,
        eventTime: AnalyticsListener.EventTime,
        error: Exception?
    ) {
        // do nothing
    }

    override fun appStop(time: Long) {
        // do nothing
    }

    override fun resetPasswordEvent(
        status: String?,
        email: String?,
        mobile: String?,
        errorMessage: String?,
        errorCode: String?
    ) {
        //do nothing
    }

    override fun changePasswordEvent(
        status: String?,
        email: String?,
        errorMessage: String?,
        errorCode: String?
    ) {
        //do nothing
    }

    override fun appSettingsEvent(
        wifiSetting: Boolean?,
        themeSetting: String?,
        languageSetting: String?,
        qualitySetting: String?
    ) {
        //do nothing
    }

    override fun enableDeviceEvent(
        deviceid: String?,
        enable: Boolean?,
        status: String?,
        deviceType: String?,
        deviceOS: String?
    ) {
        //do nothing
    }

    override fun browsingContentEvent(fromScreen: String?, toScreen: String?) {
        //donothing
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
        //donothing
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
        //do nothing
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
        //do nothing
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
        //do nothing
    }

    override fun appActionEvents(status: String?, rating: String?) {
        // do nothing
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
        //do nothing
    }

    override fun apiTokenEvent(
        status: String?,
        errorMessage: String?,
        xXXxerrorCode: String?
    ) {
        //do nothing
    }

    override fun searchEvent(
        fromScreen: String?,
        searchType: String?,
        searchSource: String?,
        keyword: String?,
        searchCount: String?,
        nextAction: String?
    ) {
        //donothing
    }
}
