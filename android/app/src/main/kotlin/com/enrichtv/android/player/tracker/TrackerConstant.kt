//@file:Suppress("unused")

package com.enrichtv.android.tracker

/**
 * @author Mohan
 * @since 10/08/2020
 **/
object TrackerConstant {

    // Events
    const val EVENT_PAYMENT_FAILED = "Payment Failed"

    // Parameters
    const val PROPERTY_AGE = "Age"
    const val PROPERTY_APP_VERSION = "AppVersion"
    const val PROPERTY_COUNTRY = "Country"
    const val PROPERTY_CURRENCY_CODE = "Currency Code"

    // Event Properties
    const val PROPERTY_ERROR_REASON = "Error Reason"
    const val PROPERTY_ERROR_TYPE = "Error Type"
    const val PROPERTY_IDENTITY = "Identity"
    const val PROPERTY_OBJECT_ID = "Object ID"
    const val PROPERTY_OBJECT_NAME = "Object Name"
    const val PROPERTY_OBJECT_QUALITY = "Object Quality"
    const val PROPERTY_PAYMENT_ID = "Payment ID"
    const val PROPERTY_PHONE = "Phone"
    const val PROPERTY_PLAN_ID = "Plan ID"
    const val PROPERTY_PLAN_NAME = "Plan Name"
    const val PROPERTY_PLATFORM = "Platform"
    const val PROPERTY_PLAYBACK_TYPE = "Playback Type"
    const val PROPERTY_PROFILE_IMAGE = "Photo"
    const val PROPERTY_QUALITY = "Quality"
    const val PROPERTY_REGISTRATION_START_DATE = "RegistrationStartDate"
    const val PROPERTY_SIGN_UP_MODE = "Sign Up Mode"
    const val PROPERTY_START_POSITION = "Start Position"
    const val PROPERTY_STREAMED_UP_TO_25 = "Streamed Upto 25%"
    const val PROPERTY_STREAMED_UP_TO_50 = "Streamed Upto 50%"
    const val PROPERTY_STREAMED_UP_TO_75 = "Streamed Upto 75%"
    const val PROPERTY_FINISHED_WATCHING = "Finished Watching"
    const val PROPERTY_SUBSCRIBER_ID = "subscriber_id"
    const val PROPERTY_SUBSCRIPTION_END_DATE = "SubscriptionEndDate"
    const val PROPERTY_SUBSCRIPTION_START_DATE = "SubscriptionStartDate"
    const val ACQUISTION_TYPE = "AcquistionType"
    const val SUBSCRIBER_ID = "Subscriber ID"
    const val NAME = "Name"
    const val GENDER = "Gender"
    const val EMAIL = "Email"
    const val PHONE = "Phone"
    const val DOB = "DOB"
    const val AGE = "Age"
    const val COUNTRY = "Country"
    const val TRANSACTION_ID = "Transaction ID"
    const val MEDIUM = "Medium"


    //Screen names
    const val SCREEN_ABOUT = "About"
    const val SCREEN_PARENTCONTROL = "PARENT CONTROL"

    const val SCREEN_ACTIVITY_LOG = "ActivityLog"
    const val SCREEN_ADD_PROFILE = "Add Profile"
    const val SCREEN_BUNDLES = "Bundles"
    const val SCREEN_CHANGE_PASSWORD = "Change Password"
    const val SCREEN_CHOOSE_PROFILE = "Choose Profile"
    const val SCREEN_CHROME_CAST = "ChromeCast"
    const val SCREEN_CONTACT_SUPPORT = "ContactSupport"
    const val SCREEN_DETAIL = "Detail"
    const val SCREEN_DOWNLOAD = "Downloads"
    const val SCREEN_EDIT_PROFILE = "EditProfile"
    const val SCREEN_FORGOT_PASSWORD = "Forgot Password"
    const val SCREEN_HELP = "Help"
    const val SCREEN_FEEDBACK = "Feedback"
    const val SCREEN_HOME = "Home"
    const val SCREEN_LIVE_TV = "LiveTV"
    const val SCREEN_LOGIN = "Login"
    const val SCREEN_LOOK_UP = "Look Up"
    const val SCREEN_MENU = "Menu"
    const val SCREEN_MOVIES = "Movies"
    const val SCREEN_MUSIC = "Music"
    const val SCREEN_NEXT_OVERLAY = "Next Overlay"
    const val SCREEN_NOTIFICATION = "Notifications"
    const val SCREEN_OTP_VERIFICATION = "OTP Verification"
    const val SCREEN_PAYMENT = "Payment"
    const val SCREEN_PLANS = "Plans"
    const val SCREEN_PLAYER = "Player"
    const val SCREEN_PLAYER_SETTINGS = "Player Settings"
    const val SCREEN_PLAYLIST = "Playlist"
    const val SCREEN_PRIVACY_POLICY = "Privacy Policy"
    const val SCREEN_PROFILE_SWITCH = "ProfileSwitch"
    const val SCREEN_PROMOTIONS = "Promotions"
    const val SCREEN_SEARCH = "Search"
    const val SCREEN_SEE_ALL = "See All"
    const val SCREEN_SELECT_DOWNLOAD_QUALITY = "Select Download Quality"
    const val SCREEN_SETTING = "Settings"
    const val SCREEN_SHOWS = "Shows"
    const val SCREEN_SIGN_UP = "Sign Up"
    const val SCREEN_TERMS_OF_USE = "Terms of Use"
    const val SCREEN_TICKETS = "Tickets"
    const val SCREEN_WATCH_LIST = "WatchList"

    const val MOBI_ANALYTICS_API_TOKEN = "API_TOKEN"
    const val MOBI_ANALYTICS_USER_SIGNUP = "USER_SIGNUP"
    const val MOBI_ANALYTICS_USER_LOGIN = "USER_LOGIN"
    const val MOBI_ANALYTICS_USER_LOGOUT = "USER_LOGOUT"
    const val MOBI_ANALYTICS_USER_PROFILE = "USER_PROFILE"
    const val MOBI_ANALYTICS_APP_SETTING = "APP_SETTING"
    const val MOBI_ANALYTICS_DEVICE_MANAGEMENT = "DEVICE_MANAGEMENT"
    const val MOBI_ANALYTICS_CONTENT_BROWSING = "CONTENT_BROWSING"
    const val MOBI_ANALYTICS_CONTENT_PLAYBACK = "CONTENT_PLAYBACK"
    const val MOBI_ANALYTICS_USER_ACTION = "USER_ACTION"
    const val MOBI_ANALYTICS_USER_TRANSACTION = "USER_TRANSACTION"
    const val MOBI_ANALYTICS_APP_ACTION = "APP_ACTION"
    const val MOBI_ANALYTICS_PLAYER_PERSORMANCE = "PLAYER_PERFORMANCE"


    const val MOBI_ANALYTICS_CREATE_API_TOKEN_SUCCESS = "CreateAPITokenSuccess"
    const val MOBI_ANALYTICS_CREATE_API_TOKEN_FAILED = "CreateAPITokenFailed"
    const val MOBI_ANALYTICS_SIGNUP_START = "SignupStart"
    const val MOBI_ANALYTICS_SIGNUP_SUCCESS = "SignupSuccess"
    const val MOBI_ANALYTICS_SIGNUP_FAILED = "SignupFailed"
    const val MOBI_ANALYTICS_SIGNIN_SUCCESS = "SigninSuccess"
    const val MOBI_ANALYTICS_SIGNIN_FAILED = "SigninFailed"
    const val MOBI_ANALYTICS_RESET_PASSWORD_SUCCESS = "ResetPasswordSuccess"
    const val MOBI_ANALYTICS_RESET_PASSWORD_FAILED = "ResetPasswordFailed"
    const val MOBI_ANALYTICS_LOGOUT = "Logout"
    const val MOBI_ANALYTICS_LOGOUT_ALL = "LogoutAll"
    const val MOBI_ANALYTICS_USER_PROFILE_CHANGE = "UserProfileChange"
    const val MOBI_ANALYTICS_CHANGE_PASSWORD_SUCCESS = "ChangePasswordSuccess"
    const val MOBI_ANALYTICS_CHANGE_PASSWORD_FAILED = "ChangePasswordFailed"
    const val MOBI_ANALYTICS_PROFILE_CREATE = "ProfileCreate"
    const val MOBI_ANALYTICS_CHANGE_APP_SETTING = "ChangeAppSettings"
    const val MOBI_ANALYTICS_SWITCH_PROFILE = "SwitchProfile"
    const val MOBI_ANALYTICS_DELETE_PROFILE = "DeleteProfile"
    const val MOBI_ANALYTICS_ENABLE_DEVICE = "EnableDevice"
    const val MOBI_ANALYTICS_DISABLE_DEVICE = "DisableDevice"
    const val MOBI_ANALYTICS_PIN_GENERATE = "PairingPinGenerate"
    const val MOBI_ANALYTICS_BROWSINGCONTENT = "BrowsingContent"
    const val MOBI_ANALYTICS_CONTENT_DETAILS = "ContentDetails"
    const val MOBI_ANALYTICS_SEARCH = "Search"
    const val MOBI_ANALYTICS_TRAILERVIEW_START = "TrailerViewStart"
    const val MOBI_ANALYTICS_TRAILERVIEW_STOP = "TrailerViewStop"
    const val MOBI_ANALYTICS_PAYMENT_SUCCESS = "PaymentSuccess"
    const val MOBI_ANALYTICS_PAYMENT_FAILED = "PaymentFailed"
    const val MOBI_ANALYTICS_SUBSCRIPTION_SUCCESS = "SubscriptionSuccess"
    const val MOBI_ANALYTICS_SUBSCRIPTION_FAILED = "SubscriptionFailed"
    const val MOBI_ANALYTICS_COUPN_REDEMPTION_SUCCESS = "CouponRedemptionSuccess"
    const val MOBI_ANALYTICS_COUPN_REDEMPTION_FAILED = "CouponRedemptionFailed"
    const val MOBI_ANALYTICS_PURCHASE_SUCCESS = "PurchaseSuccess"
    const val MOBI_ANALYTICS_PURCHASE_FAILED = "PurchaseFailed"

    const val MOBI_ANALYTICS_TRAILERVIEW_FAILED = "TrailerViewFailed"
    const val MOBI_ANALYTICS_ADD_TO_WATCHLIST = "AddToWatchlist"
    const val MOBI_ANALYTICS_REMOVE_FROM_WATCHLIST = "RemoveFromWatchlist"
    const val MOBI_ANALYTICS_SHARE_CONTENT = "ShareContent"
    const val MOBI_ANALYTICS_RATE_CONTENT = "RateContent"
    const val MOBI_ANALYTICS_CONTENT_CASTING = "ContentCasting"
    const val MOBI_ANALYTICS_CONTENTVIEW_START = "ContentViewStart"
    const val MOBI_ANALYTICS_CONTENTVIEW_PAUSED = "ContentViewPaused"
    const val MOBI_ANALYTICS_CONTENTVIEW_RESUMED = "ContentViewResumed"
    const val MOBI_ANALYTICS_CONTENTVIEW_STOP = "ContentViewStop"
    const val MOBI_ANALYTICS_CONTENTVIEW_FAILED = "ContentViewFailed"
    const val MOBI_ANALYTICS_LIKE_CONTENT = "LikeContent"
    const val MOBI_ANALYTICS_DISLIKE_CONTENT = "DislikeContent"
    const val MOBI_ANALYTICS_DOWNLOAD_START = "DownloadStart"
    const val MOBI_ANALYTICS_DOWNLOAD_SUCCESS = "DownloadSuccess"
    const val MOBI_ANALYTICS_DOWNLOAD_FAILED = "DownloadFailed"
    const val MOBI_ANALYTICS_DOWNLOAD_PAUSE = "DownloadPause"
    const val MOBI_ANALYTICS_DOWNLOAD_RESUME = "DownloadResume"
    const val MOBI_ANALYTICS_DOWNLOAD_CANCEL = "DownloadCancel"
    const val MOBI_ANALYTICS_DOWNLOAD_DELETE = "DownloadDelete"
    const val MOBI_ANALYTICS_RATE_APP = "RateApp"
    const val MOBI_ANALYTICS_CONTACT_SUPPORT = "ContactSupport"

    const val MOBI_ANALYTICS_PLAY_LOAD_TIME = "PlayLoadTime"
    const val MOBI_ANALYTICS_PLAY_BUFFER_TIME = "PlayBufferTime"
    const val MOBI_ANALYTICS_PLAY_BW_CHANGE = "PlayBWChange"
    const val MOBI_ANALYTICS_PLAY_FRAME_DROP = "PlayFrameDrop"
    const val MOBI_ANALYTICS_PLAY_SYNC_STATUS = "PlaySyncStatus"
    const val MOBI_ANALYTICS_PLAY_SEEK = "PlaySeek"
    const val MOBI_ANALYTICS_PLAY_AUDIO_CHANGE = "PlayAudioChange"
    const val MOBI_ANALYTICS_PLAY_SUBTITLE_CHANGE = "PlaySubtitleChange"
    const val MOBI_ANALYTICS_PLAY_PAUSE = "PlayPause"
    const val MOBI_ANALYTICS_PLAY_RESUME = "PlayResume"
    const val MOBI_ANALYTICS_PLAY_REPLAY = "PlayReplay"


    const val MOBI_ANALYTICS_TYPE = "Type"
    const val MOBI_ANALYTICS_NAME = "Name"
    const val MOBI_ANALYTICS_CITY = "City"
    const val MOBI_ANALYTICS_REGION = "Region"
    const val MOBI_ANALYTICS_AGE = "Age"
    const val MOBI_ANALYTICS_GENDER = "Gender"
    const val MOBI_ANALYTICS_PICTURE = "Picture"
    const val MOBI_ANALYTICS_KIDSMODE = "KidsMode"
    const val MOBI_ANALYTICS_HASPIN = "HasPin"
    const val MOBI_ANALYTICS_ERROR_MESSAGE = "ErrorMessage"
    const val MOBI_ANALYTICS_ERROR_CODE = "ErrorCode"
    const val MOBI_ANALYTICS_EMAIL = "email"
    const val MOBI_ANALYTICS_MOBILENUMBER = "mobileno"
    const val MOBI_ANALYTICS_EMAIL_ = "Email"
    const val MOBI_ANALYTICS_MOBILENUMBER_ = "Mobile"
    const val MOBI_ANALYTICS_WIFISETTING = "WifiSetting"
    const val MOBI_ANALYTICS_THEMESETTING = "ThemeSetting"
    const val MOBI_ANALYTICS_LANGUAGESETTING = "LanguageSetting"
    const val MOBI_ANALYTICS_QUALITYSETTING = "QualitySetting"
    const val MOBI_ANALYTICS_TO_PROFILEID = "ToProfileId"
    const val MOBI_ANALYTICS_PROFILEID = "ProfileId"
    const val MOBI_ANALYTICS_DEVICEID = "deviceid"
    const val MOBI_ANALYTICS_DEVICE_TYPE = "DeviceTypeForPairing"
    const val MOBI_ANALYTICS_DEVICE_OS = "DeviceOsForPairing"
    const val MOBI_ANALYTICS_TO_SCREEN = "ToScreen"
    const val MOBI_ANALYTICS_FROM_SCREEN = "FromScreen"
    const val MOBI_ANALYTICS_FROM_SECTION = "FromSection"
    const val MOBI_ANALYTICS_CONTENT_TITLE = "ContentTitle"
    const val MOBI_ANALYTICS_CONTENT_ID = "ContentID"
    const val MOBI_ANALYTICS_CONTENT_TYPE = "ContentType"
    const val MOBI_ANALYTICS_PACKAGE_ID = "PackageID"
    const val MOBI_ANALYTICS_GENERE = "Genre"
    const val MOBI_ANALYTICS_CONTENT_CATEGORY = "ContentCategory"
    const val MOBI_ANALYTICS_SEASON_NUMBER = "SeasonNumber"
    const val MOBI_ANALYTICS_EPISODE_NUMBER = "EpisodeNumber"
    const val MOBI_ANALYTICS_RECOMMENDATION_ID = "RecommendationID"
    const val MOBI_ANALYTICS_IMPRESSIONLIST = "ImpressionList"
    const val MOBI_ANALYTICS_EPISODE_PLAYBACK_MODE = "PlaybackMode"
    const val MOBI_ANALYTICS_RESUMED_FROM_PREV_SESSION = "ResumedFromPrevSession"
    const val MOBI_ANALYTICS_REFERRED_FROM = "ReferredFrom"
    const val MOBI_ANALYTICS_PLAY_DURATION = "PlayDuration"
    const val MOBI_ANALYTICS_PLAY_START_POSITION = "PlayStartPosition"
    const val MOBI_ANALYTICS_CONTENT_DURATION = "ContentDuration"
    const val MOBI_ANALYTICS_QUALITY = "Quality"
    const val MOBI_ANALYTICS_MODE = "Mode"
    const val MOBI_ANALYTICS_PERCENTAGE_WATCHED = "PercentageWatched"
    const val MOBI_ANALYTICS_SEARCH_TYPE = "SearchType"
    const val MOBI_ANALYTICS_SEARCH_SOURCE = "SearchSource"
    const val MOBI_ANALYTICS_KEYWORD = "Keyword"
    const val MOBI_ANALYTICS_SEARCH_COUNT = "SearchCount"
    const val MOBI_ANALYTICS_NEXT_ACTION = "NextAction"

    const val MOBI_ANALYTICS_PAYMENT_PROVIDER = "PaymentProvider"
    const val MOBI_ANALYTICS_PAYMENT_MODE = "Paymentmode"
    const val MOBI_ANALYTICS_TRANSACTION_TYPE = "transactiontype"
    const val MOBI_ANALYTICS_TYPE_ID = "typeid"
    const val MOBI_ANALYTICS_SUBSCRIPTIONID = "SubscriberID"
    const val MOBI_ANALYTICS_PLAN_TYPE = "PlanType"
    const val MOBI_ANALYTICS_SUBSCRIPTION_MODE = "SubscriptionMode"
    const val MOBI_ANALYTICS_SUBSCRIPTION_TYPE = "SubscriptionType"
    const val MOBI_ANALYTICS_FROM_PLANID = "FromPlanID"
    const val MOBI_ANALYTICS_PLAN_ID = "PlanID"
    const val MOBI_ANALYTICS_PLAN_NAME = "PlanName"
    const val MOBI_ANALYTICS_COUPN_CODE = "CouponCode"
    const val MOBI_ANALYTICS_COUPN_TYPE = "CouponType"
    const val MOBI_ANALYTICS_PAYMENT_ID = "PaymentID"
    const val MOBI_ANALYTICS_AMOUNT = "Amount"
    const val MOBI_ANALYTICS_DISCOUNTED_AMOUNT = "DiscountedAmount"
    const val MOBI_ANALYTICS_CURRENCY = "Currency"
    const val MOBI_ANALYTICS_EXPIRY_DATE = "ExpiryDate"
    const val MOBI_ANALYTICS_OBJECT_TYPE = "ObjectType"
    const val MOBI_ANALYTICS_OBJECT_ID = "ObjectID"
    const val MOBI_ANALYTICS_OBJECT_NAME = "ObjectName"
    const val MOBI_ANALYTICS_PURCHASE_TYPE = "PurchaseType"
    const val MOBI_ANALYTICS_RATING = "Rating"

    const val MOBI_ANALYTICS_LOAD_TIME = "LoadTime"
    const val MOBI_ANALYTICS_BW_VALUE = "BandwidthValue"
    const val MOBI_ANALYTICS_FRAME_DROPOUT_COUNT = "FrameDropCount"
    const val MOBI_ANALYTICS_SYNC_STATUS = "SyncStatus"
    const val MOBI_ANALYTICS_DIRECTION = "Direction"
    const val MOBI_ANALYTICS_LANGUAGE = "Language"
    const val MOBI_ANALYTICS_TRACK_ID = "TrackID"
    const val SUCCESS = "success"
    const val PAYMENT_SUCCESS = "Paymentsuccess"
    const val PAYMENT_FAILED = "Paymentfailed"
    const val COUPON_REDEMPTION_SUCCESS = "CouponRedemptionSuccess"
    const val COUPON_REDEMPTION_AND_PURCHASE_FAILED = "CouponRedemptionandPurchaseFailed"
    const val PURCHASE_SUCCESS = "PurchaseSuccess"
    const val CONTACT_SUPPORT = "ContactSupport"
    const val FAILED = "failed"
    const val GENERATE_PIN = "generatepin"
    const val SUBSCRIPTION_SUCCESS = "subscriptionSuccess"
    const val SUBSCRIPTION_FAILED = "subscriptionFailed"
    const val PAUSED = "paused"
    const val RESUMED = "resumed"
    const val STOP = "stop"
    // player performance
    const val PLAY_LOAD_TIME = "PlayLoadTime"
    const val PLAY_BUFFER_TIME = "PlayBufferTime"
    const val PLAY_BW_CHANGE = "PlayBWChange"
    const val PLAY_FRAME_DROP = "PlayFrameDrop"
    const val PLAY_SYNC_STATUS = "PlaySyncStatus"
    const val PLAY_SEEK = "PlaySeek"
    const val PLAY_AUDIO_CHANGE = "PlayAudioChange"
    const val PLAY_SUBTITLE_CHANGE = "PlaySubtitleChange"
    const val PLAY_PAUSE = "PlayPause"
    const val PLAY_RESUME = "PlayResume"
    const val PLAY_REPLAY = "PlayReplay"
}