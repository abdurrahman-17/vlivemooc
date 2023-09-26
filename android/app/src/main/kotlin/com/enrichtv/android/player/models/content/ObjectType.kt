package com.enrichtv.android.player.models.content

import androidx.annotation.Keep

@Suppress("unused")
@Keep
enum class ObjectType {

    CONTENT, SERIES, SEASON, ALBUM, CHANEL, EVENT, BUNDLE, MUSIC
}

@Keep
enum class ObjectStatus {
    PRELAUNCH, ACTIVE, INACTIVE
}

enum class ObjectTag {
    PREMIUM
}


enum class DrmScheme {
    WIDEVINE, NONE
}

@Keep
enum class ContentQuality {
     SD, HD//HD contains HD Ready(720) and FullHD(1080)
    ,
    ULTRAHD//,4K
}
