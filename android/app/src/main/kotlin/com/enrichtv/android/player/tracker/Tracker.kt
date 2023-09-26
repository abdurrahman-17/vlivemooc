package com.mobiotics.vlive.android.tracker

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.enrichtv.android.player.models.content.Content
import com.google.android.exoplayer2.analytics.AnalyticsListener
import java.util.Date

/**
 * Analytics interface which contains all the analytics event functions.
 *
 * Uses Decorator pattern for kotlin for the Derived classes
 *
 * @author Mohan
 * @since 5 Aug 2020
 */
interface Tracker {

    /**
     * Tracks Download Completed Event
     * @param content
     *
     * @author Joan Cynthia
     * @since 04/08/2020
     * */
    fun downloadCompleted(content: Content?)

    /**
     * Tracks Download Initiated Event
     * @param content
     *
     * @author Joan Cynthia
     * @since 04/08/2020
     * */
    fun downloadInitiated(content: Content?)


    /**
     * Tracks Charged Event
     *
     * @param paymentMode
     * @param startDate
     * @param endDate
     * @param transactionId
     * @param amount
     * @param paymentId
     * @param promoCode
     * @param discountAmount
     * @param planId
     * @param freeTrial
     * @param planName
     * @param currencyCode
     * @param objectId
     * @param objectName
     * @param objectQuality
     *
     * @author Joan Cynthia
     * @since 10/08/2020
     * */
    fun paymentCompleted(
        freeTrial: Boolean? = null,
        paymentMode: String? = null,
        startDate: Date? = null,
        endDate: Date? = null,
        transactionId: String? = null,
        amount: Int? = null,
        currencyCode: String? = null,
        paymentId: String? = null,
        promoCode: String? = null,
        discountAmount: Double? = null,
        planId: String? = null,
        planName: String? = null,
        objectId: String? = null,
        objectName: String? = null,
        objectQuality: String? = null
    )

    /**
     * Tracks the Payment failed event.
     *
     * @param paymentMode
     * @param amount
     * @param currencyCode
     * @param paymentId
     * @param promoCode
     * @param discountAmount
     * @param freeTrial
     * @param planId
     * @param planName
     * @param objectId
     * @param objectName
     * @param objectQuality
     * @param errorReason
     */
    fun paymentFailed(
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
    )



    /**
     * Tracks Play Started Event
     * @param content
     * @param playbackType
     * @param startPosition
     *
     * @author Joan Cynthia
     * @since 04/08/2020
     * */
    fun playStartedEvent(content: Content?, playbackType: PlaybackType, startPosition: Long)

    /**
     * Tracks Watched Event
     * @param content
     * @param watchDuration
     * @param watchTime
     * @param isFinished
     *
     * @author Joan Cynthia
     * @since 04/08/2020
     * */
    fun playWatchedEvent(
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
    )


    /**
     * Tracks Search Event
     * @param query
     *
     * @author Joan Cynthia
     * @since 04/08/2020
     * */
    fun searchEvent(query: String)

    /**
     * Tracks Share Event
     * @param content
     * @param medium
     *
     * @author Joan Cynthia
     * @since 04/08/2020
     * */
    fun shareEvent(content: Content?, medium: String)

    /**
     * Tracks SignUp Event
     * @param signUpMode
     * @param status
     * @param errorReason
     * @param email
     * @param mobileNo
     * @param name
     * @param city
     * @param region
     * @param age
     * @param gender
     * @param code
     *
     * @author Joan Cynthia
     * @since 04/08/2020
     * */
    fun signUpEvent(
        signUpMode: String,
        status: String,
        errorReason: String? = null,
        email: String? = null,
        mobileNo: String? = null,
        name: String? = null,
        city: String? = null,
        region: String? = null,
        age: String? = null,
        gender: String? = null,
        code: String? = null
    )

    /**
     * Tracks Subscription Updated Event
     * @param status
     * @param startDate
     * @param endDate
     * @param type
     *
     * @author Joan Cynthia
     * @since 10/08/2020
     * */
    fun subscriptionUpdated(
        objectId: String?,
        planName: String?,
        status: String,
        startDate: Date?,
        endDate: Date?,
        type: String
    )

    /**
     * Screen track event
     *
     * @param activity Activity instance
     * @param screenName Activity name
     */
    fun trackScreen(activity: AppCompatActivity?, screenName: String)

    /**
     * Screen Track Event
     *
     * @param fragment Fragment instance
     * @param screenName Fragment page name.
     */
    fun trackScreen(fragment: Fragment?, screenName: String)

    /**
     * Track login event
     * @param status [String]
     * @param loginMode [String]
     * @param errorReason [String]
     * @param errorCode
     * @param email
     * @param mobileNumber
     *
     * @author Mohan
     * @since 16/09/2020
     * */
    fun userLoginStatus(
        loginMode: String?,
        status: String?,
        errorReason: String? = null,
        errorCode: String? = null,
        email: String? = null,
        mobileNumber: String? = null
    )

    /**
     * Track login event
     * @param profileId [String]
     * @param isKid [Boolean]
     * @param hasPin [Boolean]
     * @param age
     * @param gender
     * @param picture
     *
     * @author Mohan
     * @since 16/09/2020
     * */
    fun createProfile(
        profileId: String,
        isKid: Boolean,
        hasPin: Boolean,
        age: String? = null,
        gender: String? = null,
        picture: String? = null
    )

    /**
     * Track logout event
     *
     * @author Mohan
     * @since 16/09/2020
     * */
    fun logout()

    /**
     * Track switch profile event
     *
     * @author Mohan
     * @since 16/09/2020
     * */
    fun switchProfile(profileId: String? = null)

    /**
     * Track delete profile event
     * @param profileId [String]
     *
     * @author Mohan
     * @since 16/09/2020
     * */
    fun deleteProfile(profileId: String?)

    /**
     * Track page view event
     * @param screenName [String]
     * @param actualScreenName [String]
     *
     * @author Mohan
     * @since 16/09/2020
     * */
    fun pageView(screenName: String, actualScreenName: String?)

    /**
     * Track user action event
     * @param actionName [String]
     * @param contentID
     * @param contentTitle
     * @param contentType
     * @param contentCategory
     * @param genre
     * @param medium
     * @param rating
     * @param packageID
     * @param mode
     * @param quality
     *
     * @author Mohan
     * @since 16/09/2020
     * */
    fun action(
        actionName: String?,
        contentID: String? = null,
        contentTitle: String? = null,
        contentType: String? = null,
        contentCategory: String? = null,
        genre: String? = null,
        medium: String? = null,
        rating: String? = null,
        packageID: String? = null,
        mode: String? = null,
        quality: String? = null
    )

    /**
     * Tracks Share App
     * @param medium
     *
     * @author Ratnesh Kumar Ratan
     * @since 06/01/2021
     * */
    fun shareApp(medium: String)

    /**
     * Tracks Rated Event
     * @param content
     *
     * @author Ratnesh Kumar Ratan
     * @since 04/08/2020
     * */
    fun rated(content: Content?, rating: String)

    /**
     * Tracks Drmsession Event
     * @param eventName
     * @param eventTime
     *@param error
     *
     * */
    fun drmSession(
        eventName: String,
        eventTime: AnalyticsListener.EventTime,
        error: Exception? = null
    )

    /**
     * Tracks AppStop Event
     * @param time
     *
     * */
    fun appStop(time: Long)

    /**
     * Tracks resetpassword Event
     *
     * @param status
     * @param email
     * @param mobile
     * @param errorMessage
     * @param errorCode
     *
     * */

    fun resetPasswordEvent(
        status: String?,
        email: String? = null,
        mobile: String? = null,
        errorMessage: String? = null,
        errorCode: String? = null
    )

    /**
     * Tracks Change Password Event
     *
     * @param status
     * @param email
     * @param errorMessage
     * @param errorCode
     *
     * */

    fun changePasswordEvent(
        status: String?,
        email: String? = null,
        errorMessage: String? = null,
        errorCode: String? = null
    )

    /**
     * Tracks AppSettings Event
     *
     * @param wifiSetting
     * @param themeSetting
     * @param languageSetting
     * @param qualitySetting
     *
     * */
    fun appSettingsEvent(
        wifiSetting: Boolean? = null,
        themeSetting: String? = null,
        languageSetting: String? = null,
        qualitySetting: String? = null
    )

    /**
     * Tracks Device Event
     *
     * @param deviceid
     * @param enable
     * @param status
     * @param deviceType
     * @param deviceOS
     *
     * */
    fun enableDeviceEvent(
        deviceid: String? = null,
        enable: Boolean? = false,
        status: String? = null,
        deviceType: String? = null,
        deviceOS: String? = null
    )

    /**
     * Tracks Browsing Content Event
     *
     * @param fromScreen
     * @param toScreen
     *
     * */

    fun browsingContentEvent(fromScreen: String?, toScreen: String?)

    /**
     * Tracks Content Details Event
     *
     * @param fromScreen
     * @param fromSection
     * @param contentTitle
     * @param contentID
     * @param contentType
     * @param genre
     * @param contentCategory
     * @param seasonNumber
     * @param episodeNumber
     * @param recommendationID
     * @param impressionList
     *
     * */

    fun contentDetailsEvent(
        fromScreen: String? = null,
        fromSection: String? = null,
        contentTitle: String? = null,
        contentID: String? = null,
        contentType: String? = null,
        genre: String? = null,
        contentCategory: String? = null,
        seasonNumber: String? = null,
        episodeNumber: String? = null,
        recommendationID: String? = null,
        impressionList: String? = null
    )

    /**
     * Tracks Search Event
     *
     * @param fromScreen
     * @param searchType
     * @param searchSource
     * @param keyword
     * @param searchCount
     * @param nextAction
     *
     * */

    fun searchEvent(
        fromScreen: String? = null,
        searchType: String? = null,
        searchSource: String? = null,
        keyword: String? = null,
        searchCount: String? = null,
        nextAction: String? = null
    )

    /**
     * Tracks Content View Event
     *
     * @param status
     * @param contentID
     * @param contentType
     * @param packageID
     * @param contentTitle
     * @param genre
     * @param contentCategory
     * @param seasonNumber
     * @param episodeNumber
     * @param playbackMode
     * @param playStartPosition
     * @param playDuration
     * @param contentDuration
     * @param resumedFromPrevSession
     * @param referredFrom
     * @param percentageWatched
     * @param recommendationID
     * @param impressionList
     * @param errorMessage
     * @param errorCode
     *
     * */
    fun contentViewEvents(
        status: String? = null,
        contentID: String? = null,
        contentType: String? = null,
        packageID: String? = null,
        contentTitle: String? = null,
        genre: String? = null,
        contentCategory: String? = null,
        seasonNumber: String? = null,
        episodeNumber: String? = null,
        playbackMode: String? = null,
        playStartPosition: String? = null,
        playDuration: String? = null,
        contentDuration: String? = null,
        resumedFromPrevSession: String? = null,
        referredFrom: String? = null,
        percentageWatched: String? = null,
        recommendationID: String? = null,
        impressionList: String? = null,
        errorMessage: String? = null,
        errorCode: String? = null
    )

    /**
     * Tracks Trailer View Event
     *
     * @param status
     * @param contentID
     * @param contentTitle
     * @param genre
     * @param contentCategory
     * @param quality
     * @param percentageWatched
     * @param errorMessage
     * @param errorCode
     *
     * */
    fun trailerViewEvents(
        status: String? = null,
        contentID: String? = null,
        contentTitle: String? = null,
        genre: String? = null,
        contentCategory: String? = null,
        quality: String? = null,
        percentageWatched: String? = null,
        errorMessage: String? = null,
        errorCode: String? = null
    )

    /**
     * Tracks Payment Event
     *
     * @param status
     * @param paymentProvider
     * @param paymentmode
     * @param transactiontype
     * @param typeid
     * @param subscriberID
     * @param planType
     * @param subscriptionMode
     * @param subscriptionType
     * @param fromPlanID
     * @param planID
     * @param planName
     * @param couponCode
     * @param couponType
     * @param paymentID
     * @param amount
     * @param discountedAmount
     * @param currency
     * @param errorMessage
     * @param errorCode
     * @param expiryDate
     * @param objectID
     * @param objectName
     * @param objectType
     * @param purchaseType
     * @param quality
     *
     * */
    fun paymentEvents(
        status: String? = null,
        paymentProvider: String? = null,
        paymentmode: String? = null,
        transactiontype: String? = null,
        typeid: String? = null,
        errorMessage: String? = null,
        errorCode: String? = null,
        subscriberID: String? = null,
        planType: String? = null,
        subscriptionMode: String? = null,
        subscriptionType: String? = null,
        fromPlanID: String? = null,
        planID: String? = null,
        planName: String? = null,
        couponCode: String? = null,
        couponType: String? = null,
        paymentID: String? = null,
        amount: String? = null,
        discountedAmount: String? = null,
        currency: String? = null,
        expiryDate: String? = null,
        objectID: String? = null,
        objectName: String? = null,
        objectType: String? = null,
        purchaseType: String? = null,
        quality: String? = null
    )

    /**
     * Tracks AppAction Event
     *
     * @param status
     * @param rating
     *
     * */
    fun appActionEvents(status: String?, rating: String? = null)

    /**
     * Tracks PlayerPerformance Event
     *
     * @param status
     * @param loadTime
     * @param contentID
     * @param packageID
     * @param contentTitle
     * @param contentCategory
     * @param bandwidthValue
     * @param frameDropoutCount
     * @param syncStatus
     * @param direction
     * @param trackId
     * @param language
     *
     * */

    fun playerPerformanceEvents(
        status: String?,
        loadTime: String? = null,
        contentID: String? = null,
        packageID: String? = null,
        contentTitle: String? = null,
        contentCategory: String? = null,
        bandwidthValue: String? = null,
        frameDropoutCount: String? = null,
        syncStatus: String? = null,
        direction: String? = null,
        trackId: String? = null,
        language: String? = null,
    )

    /**
     * Tracks API Token Event
     *
     * @param status
     * @param errorMessage
     * @param errorCode
     *
     * */

    fun apiTokenEvent(
        status: String?,
        errorMessage: String? = null,
        errorCode: String? = null
    )
}
