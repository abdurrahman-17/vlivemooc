/**
 * This file storing all constants
 */
@file:Suppress("SpellCheckingInspection")

package com.enrichtv.android.player

import android.view.View
import androidx.annotation.Keep

/**
 * Constant file here we mention all app constant
 *
 * @modifier sudhir kumar
 * @since 13/02/2020
 */
@Keep
object Constants {
    const val KEY_HAS_PRE_LOGIN: String = "has_pre_login"
    const val WIDEVINE: String = "widevine"
    const val NONE: String = "none"
    const val ANDROID: String = "ANDROID"
    const val BROADCAST: String = "BROADCAST"
    const val SUBSCRIBED: String = "SUBSCRIBED"
    const val playerSecurity: String = "PlayerSecurity"

    //Start from
    const val FROM_DETAIL_PAGE = "DetailActivity" // pass  when we are navigate from detail page
    const val FROM_HOME_PAGE = "HomeFragment" // pass  when we are navigate from detail page
    const val FROM_DETAIL_LIST = "DetailList"  //Pass  if navigate from settings
    const val FROM_HELP_PAGE = "HelpFragment"
    const val KEY_START_FROM = "start_from"
    const val KEY_AVAILABILITY_IDS: String = "availability_ids"
    const val KEY_FRAGMENT_TYPE: String = "fragment_type"
    const val ACTION_NONE: String = "NONE"

    //Downalod will start after this time delay
    const val DOWNLOAD_TIME_DELAY: Long = 200L



    //Flag for full screen
    const val flagFullScreen = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
            or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
            or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
            or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
            or View.SYSTEM_UI_FLAG_FULLSCREEN
            or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)

    const val COUNTRY_API_END_POINT: String =
        "https://d1v8zxa9gk5f.cloudfront.net/COMMONFILES/country-phone.json"
    const val KEY_LOOK_UP_TYPE: String = "look_up_type"
    const val KEY_LOOK_UP_DATA: String = "look_up_data"
    const val KEY_COUNTRY_CODE: String = "country_code"
    const val KEY_COUNTRY: String = "country"

    //request code for permission and activity/fragment result
    const val FILE_REQUEST_CODE = 1001
    const val CREATE_TICKET_ACTIVITY_RESULT_CODE = 1002
    const val WRITE_EXTERNAL_STORAGE_REQUEST_CODE = 1003
    const val REQUEST_CODE_DIRECT_PAYMENT: Int = 1006
    const val REQUEST_CODE_AVAILABILITY_CHECK_PLAY: Int = 1007
    const val REQUEST_CODE_CREATE_PLAN: Int = 1008
    const val REQUEST_CODE_ACTIVATE_PLAN: Int = 1009
    const val REQUEST_CODE_AVAILABILITY_CHECK_DOWNLOAD: Int = 1010
    const val REQUEST_CODE_CREATE_PURCHASE: Int = 1011
    const val FINGERPRINT_DELAY: Long = 30
    const val ERROR_CODE_PLAN_DUPLICATE: Int = 3111

    const val ZERO_DOUBLE: Double = 0.00
    const val NO_VALID_BILL_ID: String = "Pass bill is if subscription status is RENEW"
    const val SUBSCRIPTION_ACTION_ACTIVATE: String = "ACTIVE"
    const val SUBSCRIPTION_ACTION_CANCEL: String = "CANCEL"
    const val PLAN_BUTTON_PENDING: String = "plan_pending"
    const val PLAN_BUTTON_RENEW: String = "renew_plan"
    const val PLAN_BUTTON_TRY_NOW: String = "try_now"
    const val PLAN_BUTTON_CANCEL: String = "cancel_plan"
    const val PLAN_BUTTON_CANCEL_TRY: String = "cancel_plan_try"
    const val PLAN_BUTTON_REACTIVE: String = "re_active"
    const val PLAN_BUTTON_SUBSCRIBE_NOW: String = "subscribe_now"
    const val PLAN_TYPE: String = "plantype"
    const val COUPON_ID: String = "couponid"
    const val PLAN_STATUS: String = "planstatus"
    const val PLAN_LIST: String = "planlist"
    const val PLAN_ID: String = "planid"
    const val ORDER_ID: String = "orderid"
    const val GATEWAY_ID: String = "gatewayid"
    const val PLAN_NAME: String = "planname"
    const val KEY_PAGE: String = "page"
    const val PAGE_SIZE: String = "pagesize"
    const val REGION: String = "region"
    const val AVAILABILITY_SET: String = "availabilityset"
    const val DISPLAY_LANGUAGE: String = "displaylanguage"
    const val QUALITY: String = "quality"
    const val DIRECTPLAY = "DIRECTPLAY"
    const val SECURITY_LEVEL = "SECURITYLEVEL"

    const val HD: String = "HD"
    const val KEY_SEASON: String = "KEY_SEASON"
    const val KEY_DEVICE_CATEGORY: String = "device_category"
    const val KEY_NAVIGATE_FLAG: String = "navigate_flag"
    const val KEY_MOBILE = "key_mobile"
    const val KEY_GENERATE_OTP = "key_generate_otp"
    const val KEY_OTP = "key_otp"
    const val KEY_OTP_RESEND = "key_otp_resend"
    const val KEY_CHECKOUT = "checkout_key"
    const val CHECKOUT = "CHECKOUT"
    const val GOOGLEINAPP = "GOOGLEINAPP"
    const val ISREASONMANDATORY = "isReasonMandatory"

    // define Int value

    const val MINUS_DEFAULT = -1
    const val ZERO = 0
    const val ONE = 1
    const val MAX_SIZE_PDF = 1
    const val DEFAULT_PAGE = 1
    const val TWO = 2
    const val DEFAULT_SPAN_COUNT: Int = 2
    const val THREE = 3
    const val MIN_DEVICE_COUNT: Int = 3
    const val DESCRIPTION_MAX_LINE_SIZE = 3
    const val PIN_LENGTH = 4
    const val FOUR = 4
    const val FIVE = 5
    const val SIX = 6
    const val MAX_SIZE_IMAGE = 1
    const val DUMMY_CONTENT_SIZE = 5
    const val EIGHT = 8
    const val TEN = 10
    const val HOME_PAGINATION_LIMIT = 5
    const val TWELVE = 12
    const val THIRTEEN = 13
    const val SIXTEEN = 16
    const val PAGE_LIMIT = 15
    const val FIFTEEN = 15
    const val TWENTY = 20
    const val TWENTY_FIVE = 25
    const val TWENTY_SIX = 26
    const val FIFTY = 50
    const val FIFTY_ONE = 51
    const val SEVENTY_FIVE = 75
    const val NINETY = 90
    const val EIGHTY = 80
    const val HUNDRER = 100
    const val NINTYFIVE = 95
    const val MAX_SIZE_DOC = 100
    const val DOWNLOAD_PAYLOAD = 100
    const val DOWNLOAD_SELECTION_PAYLOAD = 101
    const val DOWNLOAD_STATE_PAYLOAD = 102
    const val COLOR_256 = 256
    const val SIZE_512 = 512
    const val ONE_THOUSAND = 1000
    const val FIVE_THOUSAND = 5000L
    const val REQ_LOGIN_ACTIVITY = 1004
    const val REQ_SIGN_UP_ACTIVITY = 1005
    const val KB = 1024
    const val THREE_THOUSAND_THREE_HUNDRER = 3300
    const val SEVEN_THOUSAND_FIVE_HUNDRER = 7500

    const val LONG_ZERO = 0L
    const val LONG_FIVE = 5L
    const val TIME_OUT = 30L
    const val TIME_DELAY = 200L
    const val TIME_HOME_DELAY = 100L
    const val TIME_DELAY_HALF_MIN = 500L
    const val TIME_DELAY_ONE_MIN = 1000L
    const val TIME_DELAY_TEN_MIN = 10000L
    const val TIME_DELAY_TWO_MIN = 2000L
    const val TIME_DELAY_ONE_HALF_MIN = 1500L
    const val RATING_INTERVAL = 1296000L
    const val FLOAT_TWENTY_FOUR = 24f
    const val FLOAT_ZERO = 0f
    const val FLOAT_ONE = 1f
    const val FLOAT_POINT_ONE_ONE = 0.11f
    const val FLOAT_POINT_ONE_FOUR = 0.14f
    const val FLOAT_POINT_ONE_FIVE = 0.15f
    const val FLOAT_ZERO_POINT_TWO = 0.2F
    const val FLOAT_ZERO_POINT_TWO_THREE = 0.23F
    const val PLAYLIST_ITEM_WIDTH_IN_PERCENT = 0.3F
    const val FLOAT_POINT_THREE = 0.3f
    const val FLOAT_POINT_THREE_TWO = 0.32F
    const val FLOAT_POINT_FOUR_FOUR = 0.44F
    const val FLOAT_POINT_FIVE = 0.5f
    const val FLOAT_POINT_SIX = 0.6f
    const val FLOAT_POINT_SEVEN = 0.7f
    const val FLOAT_POINT_EIGHT = 0.8f
    const val FLOAT_ZERO_POINT_SEVEN = 0.7f
    const val FLOAT_ZERO_POINT_NINE = 0.9f
    const val FLOAT_ONE_POINT_ZERO = 1.0f
    const val FLOAT_ONE_POINT_TWO = 1.2f
    const val FLOAT_THIRTY = 30f
    const val FLOAT_ZERO_POINT_ZERO_EIGHT = 0.08F
    const val FLOAT_ZERO_POINT_ONE_EIGHT = 0.18F
    const val FLOAT_ONE_POINT_SEVEN_FIVE = 1.75
    const val FLOAT_POINT_ZERO_ZERO_FIVE = 0.005
    const val HOURS_IN_SECONDS = 3600
    const val SECONDS = 60
    const val PAYMENT_INIT_DELAY = 600L
    const val NUMBER_BYTE = 1024

    const val ZERO_POINT_FIVE_ONE = 0.51
    const val ONE_POINT_ZERO = 1.0
    const val ZERO_POINT_ZERO = 0.0
    const val POINT_FIVE = 0.5
    const val ZERO_POINT_NINE = 0.9
    const val NINE_POINT_NINE_NINE = 9.99
    const val SCROLL_DURATION = 10.0
    const val TEN_POINT_ZERO = 10.0
    const val NINTY_NINE_POINT_NICE = 99.9
    const val HUNDRED_POINT_ZERO = 100.00
    const val PIP_WIDTH = 2261
    const val PIP_HEIGHT = 1080
    const val PIP_MAX_RATIO = 2.390000

    /**
    const for ignore isDataLoadedHM value update
    isDataLoadUpdate position will start from 0 index
     */
    const val IS_DATA_LOADED_POS_NONE = -1

    const val LOOPING_CIRCLE_INDICATOR_INITIAL_POS = 0
    const val AUTO_PLAY_OFFSET_DELAY = 6000
    const val AUTO_PLAY_DEFAULT_DELAY = 4000

    /**
     * View pager start position for infinite scrolling
     *  Max value of viewpager adapter count = [Integer.MAX_VALUE]
     * */
    const val HR = "hr"
    const val MIN = "m"
    const val SEC = "s"
    const val VIEW = "Views"
    const val HOURS_PATTERN = "0"
    const val MINUTES_PATTERN = "00"
    const val VIEW_TYPE_PORTRAIT = "PORTRAIT"
    const val VIEW_TYPE_LANDSCAPE = "LANDSCAPE"
    const val VIEW_TYPE_SQUARE = "SQUARE"
    const val ERROR_IN_TICKET_API = "Ticket"
    var IS_LONG_PRESS: Boolean = false
    const val CATEGORY = "category"
    const val GENRE = "genre"
    const val FROM = "from"
    const val IS_LOGIN = "isLogin"
    const val CREATED = "Created"
    const val OTHERS = "Others"
    const val MIME_TYPE_TXT = "text/plain"
    const val MIME_TYPE_PDF = "application/pdf"
    const val MIME_TYPE_IMAGE = "image/png"
    const val REQUEST_ID = "requestId"
    const val REQUEST_STATUS = "requestStatus"
    const val FORMAT_DD_MMMM_YYYY_HH_MM_AA = "dd MMMM yyyy, hh:mm aa"
    const val FORMAT_DD_MMMM_YYYY_HH_MM = "dd MMMM yyyy, HH:mm"
    const val FORMAT_DD_MMMM_YYYY = "dd MMMM yyyy"
    const val FORMAT_hh_mm_aa = "hh:mm aa"
    const val FORMAT_DD_MMM_YYYY = "dd MMM yyyy"
    const val FORMAT_MMMM_DD_YYYY = "MMMM dd, yyyy"
    const val FORMAT_YYYY_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
    const val FORMAT_YYYY_MM_DD = "yyyy-MM-dd"
    const val FORMAT_YYYY_MM_dd_HH_mm_ss_SSSZ = "yyyy-MM-dd HH:mm:ss"
    const val UTC_DEFAULT_TIME = "23:59:59"
    const val UTC_TIMEZONE_ID = "UTC"
    const val TITLE = "title"
    const val YOU = "You"
    const val MESSAGE = "message"
    const val FILE_NAME = "filename"
    const val SUBSCRIBER_ID = "subscriberid"
    const val DOT_PNG = ".png"
    const val DOT_JPG = ".jpg"
    const val DOT_JPEG = ".jpeg"
    const val DOT_PDF = ".pdf"
    const val DOT_DOC = ".doc"
    const val DOT_DOCX = ".docx"
    const val DOT_TXT = ".txt"
    const val MIME_TYPE_ANY = "*/*"
    const val SLASH = "/"
    const val NEW_LINE = "\n"
    private const val MIME_TYPE_DOC =
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    val ARRAY_MIMETYPES = arrayOf(MIME_TYPE_DOC, MIME_TYPE_TXT, MIME_TYPE_PDF)
    val ARRAY_MIMETYPES_PDF = arrayOf(MIME_TYPE_PDF)
    const val OPEN_TICKETS = "OPEN"
    const val CLOSE_TICKETS = "CLOSED"
    const val PNG = "png"
    const val JPG = "jpg"
    const val JPEG = "jpeg"
    const val DOC = "doc"
    const val DOCX = "docx"
    const val PDF = "pdf"
    const val TXT = "txt"
    const val TLS = "xls"
    const val OTHER = "OTHER"
    const val IMAGE = "image/*"
    const val APPLICATION_MSWORD = "application/msword"
    const val CONTENT_ID = "contentId"
    const val FROM_DETAILS = "from_details"
    const val OBJECT_TYPE = "objecttype"
    const val OBJECT_ID = "objectid"
    const val TABLET = "TABLET"
    const val MOBILE = "MOBILE"
    const val TABLET_ = "Tablet"
    const val MOBILE_ = "Mobile"
    const val LIKE = "LIKE"
    const val DISLIKE = "DISLIKE"
    const val KEY_EXTRA_IS_FROM_ACTION = "is_from_action"
    const val KEY_HAS_MANAGE_PROFILE = "has_manage_profile"
    const val PREFERENCE_NAME = "vLive"
    const val EPISODES = "Episodes"
    const val TRAILER = "Trailer"
    const val COUNTRY = "country"
    const val SERIES_ID = "seriesid"
    const val SEASON_NUM = "seasonnum"
    const val PAGE = "PAGE"
    const val EXTRA_INFO = "extra_info"
    const val DESCRIPTION = "description"
    const val ACTION_NETWORK_CHANGE = "action.NETWORK_CHANGE"
    const val OLD_PASSWORD = "oldpassword"
    const val PASSWORD = "password"
    const val PROFILE_NAME = "profilename"
    const val PROFILE_TYPE = "profileType"
    const val KID_MODE = "kidsmode"
    const val GENDER = "gender"
    const val DOB = "dob"
    const val PICTURE = "picture"
    const val TOKEN = "TOKEN"
    const val COUNTRY_CODE = "COUNTRY_CODE"
    const val COUNTRY_CODE_IP = "COUNTRY_CODE_IP"
    const val AGE = "AGE"
    const val WIFI = "WIFI"
    const val NOTIFICATION_STATUS = "NOTIFICATION_STATUS"
    const val PARENTALLOCK = "PARENTALLOCK"
    const val DOWNLOAD_VIDEO_QUALITY = "DOWNLOAD_VIDEO_QUALITY1"
    const val CHECK_PG_RATING = "CHECK_PG_RATING"
    const val CHECK_PARENTAL_CONTROL = "CHECK_PARENTAL_CONTROL"
    const val TAB_POSITION = "TAB_POSITION"
    const val CHANGE_LANGUAGE = "changeLanguage"
    const val APP_LANGUAGE = "APP_LANGUAGE"
    const val PREV_USER_EMAIL = "PREV_USER_EMAIL"
    const val PREV_USER_MOBILE = "PREV_USER_MOBILE"
    const val PREV_USER_COUNTRY = "PREV_USER_COUNTRY"
    const val APP_CONFIG = "APP_CONFIG"
    const val TEMP_CONTENT = "TEMP_CONTENT"
    const val DECKING_APP_CONFIG = "DECKING_APP_CONFIG"
    const val DATA = "data"
    const val SUBSCRIPTION = "subscription"
    const val ALL = "ALL"
    const val EMPTY_STRING = ""
    const val TAG = "tags"
    const val ACTION_DETAIL = "ACTION-DETAIL"
    const val PAYMENT_RETRY_30MIN_TAG = "paymentRetry30MinTag"
    const val PAYMENT_RETRY_5MIN_TAG = "paymentRetry5MinTag"
    const val REFRESH_TOKEN_TAG = "refresh_token_tag"
    const val REFRESH_AUTH_TAG = "refresh_auth_tag"
    const val PAYMENT_RETRY_TAG = "paymentRetryTag"
    const val PARTIAL_PAYMENT = "partialPayment"
    const val OFFER_PRICE = "offerPrice"
    const val DISPLAY_TYPE = "display_type"
    const val TOP_APP_BAR = "top_app_bar"
    const val THEME = "theme"
    const val KIDS_AGE = "kidsAge"
    const val PRE_LOGIN_SCREEN = "preLoginScreen"
    const val REFERRING_LINK = "referringLink"
    const val LANDSCAPE_RATIO = "16:9"
    const val PORTRAIT_RATIO = "3:4.5"
    const val SQUARE_RATIO = "1:1"
    const val QUERY = "query"
    const val SEE_ALL_MAP = "map_params"
    const val TAG_READ_MORE_DIALOG = "ReadMoreDialog"
    const val TAG_CHOOSE_PROFILE_BOTTOMSHEET = "ChooseProfileBottomSheet"
    const val KEY_PROFILE_LIST = "profile_list"
    const val RESTART_APP = "restart_app"
    const val IS_MOBILE = "restart_app"
    const val CLOSE_BTN = "close_btn"
    const val HIDE_ADD_PROFILE = "hide_add_profile"
    const val LOOKUP_FRAGMENT_REQUEST_KEY = "result_listener_request_key"
    const val TAG_QUALITY = "Quality"
    const val TAG_LANGUAGE = "Language"
    const val COMMA = ","
    const val SEMI_COLUN = ":"
    const val EQUALS = "="
    const val TAG_RESET = "reset"
    const val CONTENT = "content"
    const val SOURCE = "source"
    const val STATUS_IN_PROGRESS = "INPROGRESS"
    const val STATUS_COMPLETED = "COMPLETED"
    const val DOLLAR = "$"
    const val DEEPLINK_PATH = "android_deeplink_path"
    const val ISO_DEEPLINK_PATH = "ios_deeplink_path"
    const val WEB_DEEPLINK_PATH = "desktop_deeplink_path"
    const val DEEPLINK = "deeplink"
    const val CLEVERTAP_DEEPLINK = "wzrk_dl"
    const val AVAILABILITY_LIST = "availability_list"
    const val AVAILABILITY_ID = "availabilityid"
    const val SELECTED_AVAILABILITY = "selected_availability"
    const val SHARE_MEDIUM_MESSAGE = "messag"
    const val SHARE_MEDIUM_GMAIL = "gmail"
    const val SHARE_MEDIUM_FACEBOOK = "facebook"
    const val SHARE_MEDIUM_WHATSAPP = "whatsapp"
    const val SHARE_MEDIUM_TWITTER = "twitter"
    const val SHARE_MEDIUM_CAP_OTHERS = "OTHERS"
    const val SHARE_MEDIUM_CAP_SMS = "SMS"
    const val SHARE_MEDIUM_CAP_MAIL = "MAIL"
    const val SHARE_MEDIUM_CAP_FACEBOOK = "FACEBOOK"
    const val SHARE_MEDIUM_CAP_WHATSAPP = "WHATSAPP"
    const val SHARE_MEDIUM_CAP_TWITTER = "WHATSAPP"
    const val SUBSCRIBER_NAME = "subscribername"
    const val EMAIL = "email"
    const val FEMALE = "FEMALE"
    const val MALE = "MALE"
    const val SYMBOL_MINUS = "-"
    const val DEVICE_JWT = "device_jwt"
    const val SESSION_EXPIRY = "session_expiry"
    const val AUTH_EXPIRY = "auth_expiry"
    const val PAYMENT_INIT = "payment_init"
    const val SESSION_JWT = "session_jwt"
    const val PARENTHESES_LEFT = "["
    const val PARENTHESES_RIGHT = "]"
    const val FULL_STOP = "."
    const val PLAN_SUFFIX = "LY"
    const val IMAGE_LINK = "image_link"
    const val ACTION_PLAY = "play"
    const val COUPON = "coupon"
    const val PLANLIST = "planlist"
    const val TAG_DETAILS = "details"
    const val REQUEST_CODE_SUBSCRIBE_PLAN = "plan_result_listener_request_key"
    const val RESULT_STATUS = "result_status"
    const val IS_BILL = "is_bill"
    const val REQUEST_CODE_RELOAD_TICKET = "request_code_reload_ticket"
    const val TAG_HOME = "home"
    const val SETTINGS_TAG = "mobile_settings"
    const val TAG_MAIN = "main"
    const val TAG_MENU = "menu"
    const val MENU = "Menu"
    const val HOME = "Home"
    const val MASTER = "MASTER"
    const val ADULT = "ADULT"
    const val KID = "KID"
    const val GENRE_KIDS = "KIDS"

    const val IS_WATCH_COMPLETELY = "is_watch_completely"
    const val LAST_REVIEW_DATE = "last_review_date"
    const val OPERATOR = "OPERATOR"
    const val CALLING_COUNTRY_CODE = "CALLING_COUNTRY_CODE"
    const val PLAN_PATH = "menu/plan/"
    const val APPEND_COUPON_PATH = "/coupon/"

    const val TRANSACTION_PURPOSE = "transaction_purpose"
    const val TRANSACTION_MODE = "transaction_mode"
    const val STATE = "state"
    const val PURCHASE = "purchase"
    const val AMOUNT = "amount"
    const val CURRENCY = "currency"
    const val DOUBLE_QUOTE = "\""
    const val CATEGORY_SEPARTOR = "\",\""

    /**
     * Firebase related constant
     **/
    const val PATH_SUBSCRIBER = "subscriber"
    const val PATH_CONTENT = "content"
    const val PATH_PAYMENT = "payments"
    const val PATH_EPISODE = "episodes"


    /**
    const for ignore isDataLoadedHM value update
    isDataLoadUpdate position will start from 0 index
     */

    const val TODAY = "TODAY"
    const val YESTERDAY = "YESTERDAY"
    const val SETTING = "setting"
    const val PLAY_LIST = "playlist"
    const val BLANK_SPACE = " "

    const val DEFAULT_PAYMENT_COUNTRY_CODE = "ROW"
    const val PLAN = "plan"
    const val YRS = "Yrs"

    // Clevertap notification related keys
    const val NOTIFICATION_TITLE = "nt"
    const val NOTIFICATION_MESSAGE = "nm"
    const val NOTIFICATION_ICON = "ico"
    const val ANDROID_RESOURCE = "android.resource://"

    //Clevertap event
    const val EVENT_PAGE_VIEW = "Page View"

    //Clevertap Event Property
    const val PROPERTY_PAGE_TITLE = "Page Title"

    //Drm security level
    const val SOFTWARE = "SW"
    const val HARDWARE = "HW"

    //ticket
    const val VIEW_TICKET = "VIEW TICKET"
    const val WATCH_NOW = "WATCH NOW"
    const val MOBILEPESA_SUCCESS_RESPONSE = "Success. Request accepted for processing"

    //InApp Constants
    const val GOOGLE_PAY_COMPLETED = "GOOGLE_PAY_COMPLETED"
    const val PAYMENT_INITIATED = "PAYMENT_INITIATED"


    const val CONTENT_DETAILS = "Content Details"
    const val CONTENT_DETAILS_LIST = "Content DetailsList"
    const val CONTENT_DOWNLOADS = "Downloads"
    const val CONTENT_SEARCH = "Search"
    const val CONTENT_PLAYER = "Player"
    const val CONTENT_DEEPLINK = "Deeplink"
    const val CONTENT_CONTINUE_WATCHING = "Continue Watching"
    const val CONTENT_WATCHLIST = "WatchList"
    const val CONTENT_NOTIFICATION = "Notification"
    const val CONTENT_CAROUSEL = "Carousal"

    //these are basic video qualities getting from player track name provider class
    const val VIDEO_QUALITY_480 = 480
    const val VIDEO_QUALITY_360 = 360
    const val VIDEO_QUALITY_240 = 240
    const val VIDEO_QUALITY_720 = 720
    const val VIDEO_QUALITY_1080 = 1080
    const val VIDEO_SIZE_FORMAT_MB = "MB"
    const val QUALITY_BEST = "best"
    const val QUALITY_HD = "hd"
    const val QUALITY_FULL_HD = "Full HD"
    const val QUALITY_BETTER = "better"
    const val QUALITY_LOW = "low"
}


const val ITEM_DOWNLOAD_VIDEO_SELECTION_QUALITY_LOW = "Low"
const val ITEM_DOWNLOAD_VIDEO_SELECTION_QUALITY_HD = "HD"
const val ITEM_DOWNLOAD_VIDEO_SELECTION_QUALITY_FULL_HD = "Full HD"
const val ITEM_DOWNLOAD_VIDEO_SELECTION_QUALITY_NONE = "None"

//Sufix for count
val suffix = arrayOf("", "k", "m", "b", "t")
const val VIEW_COUNT_DECIMAL_FORMAT = "##0E0"

