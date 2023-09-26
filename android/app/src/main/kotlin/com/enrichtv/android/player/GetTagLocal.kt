package com.enrichtv.android.player

import java.lang.Exception


/*@Singleton*/
class GetTagLocal /*@Inject*/ constructor(
   /* private val prefManager: PrefManager*/) {
    fun getTagName(tag: List<String>?): String? {
       /* try {
            tag ?: return null
            val contentTags = prefManager.appConfig?.contentTags?.get(prefManager.languageCode)
                ?: prefManager.appConfig?.contentTags?.get(ApiConstant.DEFAULT)
            return contentTags?.get(tag.first())
        }catch (exp:Exception){
            return ""
        }*/

        return ""
    }
}