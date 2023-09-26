package com.enrichtv.android.util

/**
 * Singleton creator
 *
 * @author Mohan
 * @since 5 Aug 2020
 */
open class SingletonHolder<out T : Any, in A>(creator: (A) -> T) {

    private var creator: ((A) -> T)? = creator

    @Volatile
    private var instance: T? = null

    /**
     * Returns the instance if created.
     */
    fun getInstance(): T? {
        val i = instance
        if (i != null) {
            return i
        }
        return synchronized(this) {
            val i2 = instance
            i2
        }
    }

    /**
     * Creates a new instance if the instance is not created & returns.
     */
    fun createInstance(arg: A): T {
        val i = instance
        if (i != null) {
            return i
        }

        return synchronized(this) {
            val i2 = instance
            if (i2 != null) {
                i2
            } else {
                val created = creator!!(arg)
                instance = created
                creator = null
                created
            }
        }
    }
}
