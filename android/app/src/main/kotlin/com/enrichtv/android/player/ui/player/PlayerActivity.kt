package com.enrichtv.android.player.ui.player

import android.animation.ObjectAnimator
import android.app.PendingIntent
import android.app.PictureInPictureParams
import android.app.RemoteAction
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Color
import android.graphics.drawable.Icon
import android.media.AudioAttributes
import android.media.AudioFocusRequest
import android.media.AudioManager
import android.os.*
import android.text.SpannableString
import android.text.style.ForegroundColorSpan
import android.util.Log
import android.util.Rational
import android.util.TypedValue
import android.view.*
import android.widget.ArrayAdapter
import android.widget.ImageButton
import android.widget.TextView
import androidx.annotation.DrawableRes
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatImageButton
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.Toolbar
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.Group
import androidx.core.animation.doOnEnd
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.core.view.isVisible
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.RecyclerView
import com.enrichtv.android.player.models.content.*
import com.enrichtv.android.player.models.content.Content
import com.enrichtv.android.player.models.content.Orientation
import com.enrichtv.android.player.models.content.poster
import com.google.android.exoplayer2.DefaultLoadControl
import com.google.android.exoplayer2.ExoPlaybackException
import com.google.android.exoplayer2.Player
import com.google.android.exoplayer2.PlayerMessage
import com.google.android.exoplayer2.analytics.AnalyticsListener
import com.google.android.exoplayer2.source.TrackGroupArray
import com.google.android.exoplayer2.text.CaptionStyleCompat
import com.google.android.exoplayer2.trackselection.TrackSelectionArray
import com.google.android.exoplayer2.ui.AspectRatioFrameLayout
import com.google.android.gms.cast.framework.CastContext
import com.google.android.gms.cast.framework.Session
import com.google.android.gms.cast.framework.SessionManager
import com.google.android.gms.cast.framework.SessionManagerListener
import com.google.android.gms.cast.framework.media.RemoteMediaClient
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.mobiotics.core.displayLanguage
import com.mobiotics.core.extensions.isNotNull
import com.mobiotics.core.extensions.isNull
import com.mobiotics.core.extensions.setFontFamily
import com.mobiotics.player.core.State
import com.mobiotics.player.core.StateListener
import com.mobiotics.player.core.media.MediaProvider
import com.mobiotics.player.core.ui.AutoPlayView
import com.mobiotics.player.exo.ExoPlayer
import com.mobiotics.player.exo.PlayerComponent
import com.mobiotics.player.exo.TrackSelection
import com.mobiotics.player.exo.listener.PlayerEventListener
import com.mobiotics.player.exo.ui.ExoPlayerView
import com.mobiotics.vlive.android.tracker.AnalyticsProvider
import com.mobiotics.vlive.android.tracker.PlaybackType
import com.enrichtv.android.player.ApiConstant
import com.enrichtv.android.player.ApiConstant.SHORT_MAR
import com.enrichtv.android.player.App
import com.enrichtv.android.player.Constants
import com.enrichtv.android.player.Constants.EMPTY_STRING
import com.enrichtv.android.player.Constants.FLOAT_THIRTY
import com.enrichtv.android.player.Constants.FLOAT_TWENTY_FOUR
import com.enrichtv.android.player.Constants.FLOAT_ZERO_POINT_ZERO_EIGHT
import com.enrichtv.android.player.Constants.HUNDRER
import com.enrichtv.android.player.Constants.NINTYFIVE
import com.enrichtv.android.player.Constants.ONE_THOUSAND
import com.enrichtv.android.player.GetTagLocal
import com.enrichtv.android.R
import com.enrichtv.android.databinding.ActivityPlayerBinding
import com.enrichtv.android.db.PrefManager
import com.enrichtv.android.extensions.isMobile
import com.enrichtv.android.extensions.isTablet
import com.enrichtv.android.extensions.toast
import com.enrichtv.android.flutterEngineGobal
import com.enrichtv.android.models.content.Skip
import com.enrichtv.android.player.ui.player.cast.CastButtonFactory
import com.enrichtv.android.player.util.IPFetcher
import com.enrichtv.android.player.util.buildMediaQueueItem
import com.enrichtv.android.player.util.startCast
import com.enrichtv.android.tracker.TrackerConstant
import com.enrichtv.android.tracker.TrackerConstant.FAILED
import com.enrichtv.android.tracker.TrackerConstant.PLAY_REPLAY
import com.enrichtv.android.tracker.TrackerConstant.STOP
import com.enrichtv.android.ui.player.CustomPlayListAdapter
import com.enrichtv.android.ui.player.PlayListType
import com.enrichtv.android.ui.player.PlayerAnalyticsListener
import com.enrichtv.android.ui.player.SeasonAdapter
import com.enrichtv.android.ui.player.VideoDrmAuthenticator
import com.enrichtv.android.ui.player.WatchTimer
import com.enrichtv.android.ui.player.helperclassess.CustomMediaCreator
import com.enrichtv.android.ui.player.track.TrackSelectionDialog
import com.enrichtv.android.util.*
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.util.*
import java.util.concurrent.TimeUnit

class PlayerActivity : AppCompatActivity(), PlayerMessage.Target, IPFetcher.IPListener {


    //Chrome cast variable and classes
    val sessionManager: SessionManager? by lazy {
        val castContext: CastContext = CastContext.getSharedInstance(this)
        castContext.sessionManager
    }
    private val sessionManagerListener = CastSessionAvailabilityListener()

    private lateinit var seasonRecyclerView: RecyclerView
    private var nextEpisodeId: String? = null
    private lateinit var nextEpisodeImageLayout: ConstraintLayout
    private lateinit var btnSkipIntro: AppCompatButton
    private var buttonZoom: ImageButton? = null
    lateinit var binding: ActivityPlayerBinding
    private var seasonNo: Int = 1

    private var lastSeenSubtitleLanguage: String? = null
    private var lastUsedAudioLanguage: String? = null
    private var playerSeekCheck: Boolean? = false

    private var objectAnimator: ObjectAnimator? = null

    private var playerComponent: PlayerComponent? = try {
        PlayerComponent.getInstance()
    } catch (ignored: NullPointerException) {
        null
    }
    private lateinit var content: Content

    private val speedArr: Array<String>? by lazy {
        resources.getStringArray(R.array.playback_speed)
    }
    private var alertDialog: AlertDialog? = null

    private var playListAdapter: CustomPlayListAdapter? = null
    private var playerAnalyticsListener: PlayerAnalyticsListener? = null
    private var episodeCancelFlag: Boolean? = null

    private var startPosition: Long = 0L
    val relatedChannel = "com.mobiotics.playerRelatedContent"

    private var playListType: PlayListType = PlayListType.PlayListNormal

    /**
     * Check play list closed by user
     * if(false) playlistView.show()
     * else do nothing
     * */
    private var playListClosedByUser = false
    private var isFirstTimeAutoPlay = true

    /**
     * Increase index by 1 if(played content == next),
     * this will occur only in season
     */
    private var nextMediaIndex: Int? = null
    private var scrubBitmap: Bitmap? = null
    private lateinit var seasonAdapter: SeasonAdapter
    private var playListItems: List<Content>? = null

    private val seekProcessListener: (AnalyticsListener.EventTime) -> Unit = {
        handleSkipActionButtonVisibility(it)
    }

    /** The arguments to be used for Picture-in-Picture mode.  */
    @RequiresApi(Build.VERSION_CODES.O)
    private val mPictureInPictureParamsBuilder =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            PictureInPictureParams.Builder()
        } else null

    private var mReceiver: BroadcastReceiver? = null
    lateinit var exoPlayer: ExoPlayer<Content>
    lateinit var exoPlayerView: ExoPlayerView
    var audioFocusChangeListener =
        AudioManager.OnAudioFocusChangeListener { focusChange ->
            when (focusChange) {
                AudioManager.AUDIOFOCUS_GAIN -> {
                    //Log.e("AUDIOFOCUS_GAIN","true")
                }

                AudioManager.AUDIOFOCUS_LOSS_TRANSIENT -> {
                    //Log.e("AUDIOFOCUS_LOSS","true")
                }

                AudioManager.AUDIOFOCUS_LOSS -> {
                    exoPlayer.pause()
                }
            }
        }

    private var watchTimer: WatchTimer? = null

    lateinit var prefManager: PrefManager

    /*@Inject*/
    val getTagLocal: GetTagLocal = GetTagLocal()

    /**
     * Player component
     */
    private lateinit var ipFetcher: IPFetcher

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityPlayerBinding.inflate(layoutInflater)
        setContentView(binding.root)
        //Fetch the Ip address every 30 seconds
        ipFetcher = IPFetcher(30000L, this)
        getPlayListViaChannel()
        initChromeCast()
        exoPlayerView = binding.exoPlayerView
        btnSkipIntro = binding.btnSkipIntro
        nextEpisodeImageLayout = binding.nextEpisodeImageLayout
        playerComponent?.playerConfig
        prefManager = PrefManager(this)

        lifecycleScope.launch {
            initExoPlayer()
            initStateListener()
            initPlaylist()
            initExoPlayerComponents()
            setExoPlayerMenuClickListeners()
            initPlayerMenuAction()
        }
        skipIntoInit()
    }

    /**
     * Init chrome cast
     **/
    private fun initChromeCast() {

        sessionManager?.addSessionManagerListener(sessionManagerListener)
    }

    private fun initPlaylist() {

        //remove large data
        intent?.removeExtra(Constants.CONTENT)
        content.objectid.let {
            /*isOfflineContent =
                playerComponent?.getOfflineDatabase()?.offlineDao()?.getData(it)
                    .isNotNull()*/
        }

        getPlayListFromFlutter()
        if (/*prefManager.appConfig?.featureEnabled?.isPlayerWatermarkEnabled == true*/true) {
            try {
                if (/*prefManager.appConfig?.providerDetails?.playerWatermark?.get("position")*/content.objectType != ObjectType.CHANEL) {
                    binding.imageWatermarkTop?.show()
                    binding.imageWatermarkTop?.setImageResource(R.drawable.ic_watermark_logo)
                    binding.imageWatermarkTop?.alpha =
                            /*prefManager.appConfig?.providerDetails?.playerWatermark?.get("alpha")
                                ?.toFloat()
                                ?:*/ 0.4f
                } else if (/*prefManager.appConfig?.providerDetails?.playerWatermark?.get("position") == "bottom"*/false) {
                    binding.imageWatermarkBottom?.show()
                    binding.imageWatermarkBottom?.setImageResource(R.drawable.ic_watermark_logo)
                    binding.imageWatermarkBottom?.alpha =
                            /*prefManager.appConfig?.providerDetails?.playerWatermark?.get("alpha")
                                ?.toFloat()
                           ?: */0.4f
                }
            } catch (exp: java.lang.Exception) {
                //do nothing
            }
        }


    }

    val channel = MethodChannel(
        flutterEngineGobal.dartExecutor.binaryMessenger,
        "com.mobiotics.androidplayer"
    )

    /**
     * This is to get the playlist from Flutter code via method channel.
     * Please note that this is only for videos.
     * this should not be called for series.
     *
     */
    private fun getPlayListViaChannel() {

        MethodChannel(
            flutterEngineGobal.dartExecutor.binaryMessenger,
            relatedChannel
        ).setMethodCallHandler { call, result ->
            if (call.method == "relatedContent") {
                playListType = PlayListType.PlayListNormal
                playListItems = Gson().fromJson(
                    call.arguments as String,
                    object : TypeToken<ArrayList<Content?>?>() {}.type
                )
                playListItems = playListItems?.filter { it.objectid != content?.objectid }
                bindPlayListContentStreams()
            } else if (call.method == "playRelatedContent") {
                (call.argument("content") as String?)?.let {
                    val content = Gson().fromJson(it, Content::class.java)
                    content.playContent()
                }

            } else if (call.method == "SeasonsEpisodes") {

                //Get Episodes and Seasons from Flutter
                playListType = PlayListType.PlayListSeries
                val seasonsList: List<Content>? =
                    Gson().fromJson(
                        call.argument("Seasons") as String?,
                    object : TypeToken<ArrayList<Content?>?>() {}.type
                )

                val episodesList: Map<Int, List<Content>>? = Gson().fromJson(
                    call.argument("Episodes") as String?,
                    object : TypeToken<Map<Int, List<Content>>?>() {}.type
                )
                print("Getting the series : ");
                if (episodesList != null && seasonsList != null) {
                    var seasonWithEpisodes = episodesList.map { (key, value) ->
                        val newKey = seasonsList.first { key == it.seasonNum }
                        newKey to value
                    }.toMap()
                    bindSeasons(seasonWithEpisodes)
                }


            } else {
                result.notImplemented()
            }

        }

    }


    private fun getPlayListFromFlutter() {

        val seriesId = content.seriesid

        //Only for the related videos
        if (seriesId == null && content.objectType != ObjectType.CHANEL) {
            channel.invokeMethod("related", content.objectid)
        } else if(content.objectType != ObjectType.CHANEL){
            //send the related content to play(to flutter code)
            val map: MutableMap<String, Any> = mutableMapOf()
            map.run {
                put("content", Gson().toJson(content))
            }
            //We need to get the map of item of episodes and list
            channel.invokeMethod("episodes", map)
            //bindSeasons;
        }
    }

    private fun initExoPlayerComponents() {

        val locale = LocaleHelper.getLocaleDirection(this)
        binding.exoPlayerView.findViewById<Toolbar>(R.id.mob_toolbar).layoutDirection = locale
        binding.playListView.layoutDirection = locale
        binding.autoPlayView.layoutDirection = locale
        initializationZoom()

    }

    /**
     * Page zoom initialization
     * @author Ratnesh Kumar Ratan
     * @since 04/11/2020
     **/
    private fun initializationZoom() {
        exoPlayerView.getPlayerView()?.resizeMode = AspectRatioFrameLayout.RESIZE_MODE_FIT
        buttonZoom = exoPlayerView.getPlayerView()?.findViewById<ImageButton>(R.id.buttonZoom)
        buttonZoom?.setImageResource(R.drawable.ic_zoom_in)
        buttonZoom?.setOnClickListener {
            val resizeMode = exoPlayerView.getPlayerView()?.resizeMode
            if (resizeMode == AspectRatioFrameLayout.RESIZE_MODE_FIT) {
                exoPlayerView.apply {
                    getPlayerView()?.subtitleView?.apply {
                        this.setBottomPaddingFraction(Constants.FLOAT_ZERO_POINT_ONE_EIGHT)
                    }
                }
                buttonZoom?.setImageResource(R.drawable.ic_zoom_out)
                exoPlayerView.getPlayerView()?.resizeMode = AspectRatioFrameLayout.RESIZE_MODE_ZOOM
            } else if (resizeMode == AspectRatioFrameLayout.RESIZE_MODE_ZOOM) {
                exoPlayerView.apply {
                    getPlayerView()?.subtitleView?.apply {
                        this.setBottomPaddingFraction(FLOAT_ZERO_POINT_ZERO_EIGHT)
                    }
                }
                buttonZoom?.setImageResource(R.drawable.ic_zoom_in)
                exoPlayerView.getPlayerView()?.resizeMode = AspectRatioFrameLayout.RESIZE_MODE_FIT
            }
        }

        /*  if (!content?.contentStream?.packagedfilelist?.scrubbing.isNullOrEmpty()) {
              Glide.with(this)
                  .asBitmap()
                  .load(content?.contentStream?.getScrubbingUrl())
                  .into(object : CustomTarget<Bitmap>() {
                      override fun onResourceReady(
                          bitmap: Bitmap,
                          transition: Transition<in Bitmap>?
                      ) {
                          scrubBitmap = bitmap
                      }

                      override fun onLoadCleared(placeholder: Drawable?) {

                      }
                  })
          }*/
        /*exo_progress.addListener(object : TimeBar.OnScrubListener {
            override fun onScrubStart(timeBar: TimeBar, position: Long) {
            }

            override fun onScrubMove(timeBar: TimeBar, position: Long) {
                if (BuildConfig.HAS_VIDEO_SCRUBBING) {
                    try {
                        val content = exoPlayer.provider().getMedia()?.t
                        if (!content?.contentStream?.packagedfilelist?.scrubbing.isNullOrEmpty()) {
                            previewFrameLayout.show()
                            val pos = position / 1000
                            val targetX =
                                updatePreviewX(
                                    pos.toInt(),
                                    exoPlayer.provider().getMedia()?.t?.duration!!
                                )
                            previewFrameLayout.x = targetX.toFloat()
                            GlideApp.with(this@PlayerActivity)
                                .load(scrubBitmap ?: content?.contentStream?.getScrubbingUrl())
                                .override(Target.SIZE_ORIGINAL, Target.SIZE_ORIGINAL)
                                .transform(
                                    GlideThumbnailTransformation(
                                        pos,
                                        content?.contentStream?.packagedfilelist?.scrubbing
                                    )
                                )
                                .into(scrubbingPreview)
                        } else previewFrameLayout.inVisible()
                    } catch (exp: Exception) {
                        previewFrameLayout.inVisible()
                    }
                }
            }

            override fun onScrubStop(timeBar: TimeBar, position: Long, canceled: Boolean) {
                *//* if (BuildConfig.HAS_VIDEO_SCRUBBING) {
                     previewFrameLayout.inVisible()
                 }*//*
            }


        })*/
    }


    private fun initExoPlayer() {

        content = Gson().fromJson(intent.getStringExtra("content")!!, Content::class.java)

        Log.e(TAG, "initExoPlayer: " + intent.getStringExtra("content"))
        Log.e(TAG, "initExoPlayer: " + content.toString())


        try {
            //Below code is avoid crash
            if (playerComponent == null) {
                (application as App).isPlayerInitialized = false
                (application as App).initPlayerConfig()
            }
            playerComponent = PlayerComponent.getInstance()
            playerComponent?.configuration

        } catch (e: NullPointerException) {
            finish()
        }
        val videoDrmAuthenticator =
            VideoDrmAuthenticator(
                intent.getStringExtra("packageid")!!, intent.getStringExtra("sessionToken"), this
            )
        val loadControl = DefaultLoadControl.Builder()
            .setBufferDurationsMs(
                DEFAULT_MIN_BUFFER_MS,
                DEFAULT_MAX_BUFFER_MS,
                DEFAULT_BUFFER_FOR_PLAYBACK_MS,
                DEFAULT_BUFFER_FOR_PLAYBACK_AFTER_RE_BUFFER_MS
            ).createDefaultLoadControl()

        exoPlayer = ExoPlayer.Builder<Content>(applicationContext)
            .setLifecycleOwner(this)
            .setMediaProvider(MediaProvider(CustomMediaCreator()))
            .setDrmAuthenticator(videoDrmAuthenticator)
            .setUseConcatenatingMediaSource(false)
            .setPreferredTextLanguage(getString(R.string.default_subtitle_language))
            .setLoadControl(loadControl)
            .setExoPlayerView(exoPlayerView)
            .build()

        Log.e(TAG, "isInitialized: " + ::exoPlayer.isInitialized)

        binding.exoPlayerView.setUpWithAutoPlay(binding.autoPlayView)
        binding.autoPlayView.addOnActionListener { action ->
            when (action) {
                AutoPlayView.Action.PLAY -> {
                    try {
                        if (::exoPlayer.isInitialized)
                            exoPlayer.apply {
                                val index = if (nextMediaIndex != null && nextMediaIndex != -1) {
                                    nextMediaIndex!!
                                } else {
                                    provider().index()
                                }
                                checkAvailability(index, seasonNo)
                                nextMediaIndex = null
                                release()
                                initPlayer()

                            }
                        nextEpisodeImageLayout.hide()
                    } catch (e: NoSuchElementException) {
                        if (!playListClosedByUser && !playListItems.isNullOrEmpty())
                            binding.playListView.show()
                    } catch (e: ArrayIndexOutOfBoundsException) {
                        // do nothing
                    }
                }

                AutoPlayView.Action.REPLAY -> {
                    AnalyticsProvider.getInstance()?.getTracker()
                        ?.playerPerformanceEvents(
                            PLAY_REPLAY,
                            contentID = exoPlayer.provider().getMedia()?.t?.objectid,
                            packageID = exoPlayer.provider()
                                .getMedia()?.t?.contentStream?.packageid,
                            contentTitle = exoPlayer.provider().getMedia()?.t?.title,
                            contentCategory = exoPlayer.provider().getMedia()?.t?.category?.name
                        )
                    if (::exoPlayer.isInitialized) {
                        exoPlayer.release()
                        exoPlayer.initPlayer()
                    }

                }
                AutoPlayView.Action.CANCEL -> {
                    // do nothing
                }
            }
        }


        exoPlayer.provider()
            .setIndex(0, seasonNo)
            .addMedia(content, season = seasonNo)
            .moveToNext()
        content.title?.let { binding.exoPlayerView.setTile(it) }


        binding.exoPlayerView.setOnCloseIconClickListener {
            finish()
        }


    }

    override fun onResume() {
        super.onResume()
        ipFetcher.startFetching()

    }

    override fun onPause() {
        super.onPause()
        ipFetcher.stopFetching()
    }

    override fun onIPFetched(ipAddress: String?) {
        // Update your UI or perform any task with the fetched IP address here
        ipAddress?.let { ip ->

            val playerSecurity: String? = intent.getStringExtra(Constants.playerSecurity)
            playerSecurity?.let {
                binding.txtSecurity.text = "$it\n$ip\n${watchTimer?.getCurrentTimeFormatted()}"
            }
        }
    }

    /**
     *  Init Player state change listener
     *
     * @author Ratnesh Kumar Ratan
     * @since 26/3/20
     *
     * @modifier Ashik
     * @since 20/07/2020
     * */
    private fun initPlayerStateListener() {
        if (::exoPlayer.isInitialized)
            exoPlayer.setPlayerEventListener(object : PlayerEventListener<Content> {
                override fun onStateChanged(t: Content?, state: State, position: Long) {
                    Log.e(TAG, "onStateChanged: ")
                    playerAnalyticsListener?.updateContent(exoPlayer.provider().getMedia()?.t)
                    if (state == State.Start) {
                        audioFocusGain()
                        exoPlayerView.setTile(
                            exoPlayer.provider().getMedia()?.t?.title
                                ?: getString(R.string.app_name)
                        )
                        if (exoPlayer.player()?.playWhenReady == true) {
                            // streamLock(t)
                            watchTimer?.init()
                        } else if (exoPlayer.player()?.playWhenReady == false) {
                            //streamUnLock(t)
                            watchTimer?.compute().also { watchTimer?.pause() }
                        }
                    }
                    if (state == State.Buffer) {
                        watchTimer?.compute()
                    }
                    if (state == State.End && exoPlayer.provider().hasNext()) {
                        playNextContent()
                        // The video stopped or reached its end. In PiP mode, we want to show an action
                        // item to play the video.
                    }
                    if (state == State.End && !exoPlayer.provider()
                            .hasNext() && !playListClosedByUser
                    ) {
                        if (!playListItems.isNullOrEmpty()) {
                            binding.playListView.show()
                            playListClosedByUser = true
                        } else {
                            binding.playListView.hide()
                            finish()
                        }
                    }

                    if (mPipMode == true) {
                        exoPlayerView.getPlayerView()
                            ?.findViewById<ConstraintLayout>(R.id.controller_layout)?.hide()
                        exoPlayerView.findViewById<Toolbar>(R.id.mob_toolbar).hide()
                        hideViews()
                    }
                    //setKeepScreen On/Off
                    exoPlayerView.keepScreenOn =
                        !(state == State.Idle || state == State.End || exoPlayer.player()?.playWhenReady == false)

                }

                override fun onError(t: Content?, error: ExoPlaybackException) {
                    Log.e(TAG, "onError: ")
                    if (exoPlayer.provider().getMedia()?.t?.isTrailer == true) {
                        AnalyticsProvider.getInstance()?.getTracker()?.trailerViewEvents(
                            FAILED,
                            contentID = exoPlayer.provider().getMedia()?.t?.objectid,
                            contentTitle = exoPlayer.provider().getMedia()?.t?.title,
                            genre = exoPlayer.provider().getMedia()?.t?.genre,
                            contentCategory = exoPlayer.provider()
                                .getMedia()?.t?.category?.name,
                            quality = when {

                                is4K() -> ContentQuality.ULTRAHD.name
                                isHd() -> ContentQuality.HD.name
                                else -> ContentQuality.SD.name
                            },
                            errorMessage = error.message
                        )
                    } else {

                        var playerCurrentPosition = exoPlayer.player()?.currentPosition
                        Log.e(TAG, "playerCurrentPosition: ")

                        print(playerCurrentPosition);
                        print(content.listDetails?.get(0)?.clearlead)
                        AnalyticsProvider.getInstance()?.getTracker()?.contentViewEvents(
                            FAILED,
                            contentID = exoPlayer.provider().getMedia()?.t?.objectid,
                            contentType = exoPlayer.provider().getMedia()?.t?.objectType?.name,
                            contentTitle = exoPlayer.provider().getMedia()?.t?.title,
                            genre = exoPlayer.provider().getMedia()?.t?.genre,
                            contentCategory = exoPlayer.provider()
                                .getMedia()?.t?.category?.name,
                            seasonNumber = exoPlayer.provider()
                                .getMedia()?.t?.seasonNum.toString(),
                            episodeNumber = exoPlayer.provider()
                                .getMedia()?.t?.episodeNum.toString(),
                            errorMessage = error.message
                        )
                    }
                }
            })
    }


    /**
     * initialization exoPlayer
     **/

    private fun setExoPlayerMenuClickListeners() {
        binding.exoPlayerView.apply {
            content?.title ?: EMPTY_STRING
            setUpWithAutoPlay(binding.autoPlayView)
            setSettingsEnabled(true)
            setCloseIcon(R.drawable.ic_back)
            setOnCloseIconClickListener { finish() }

            switchUi(content.objectType == ObjectType.CHANEL).apply {
                exoPlayerView.getPlayerView()
                    ?.run {
                        findViewById<AppCompatImageView>(R.id.textLive)?.isVisible =
                            content?.objectType == ObjectType.CHANEL
                    }
            }

            if (content.objectType == ObjectType.CHANEL) {

                val controllerLayout = exoPlayerView.getPlayerView()
                    ?.findViewById<ConstraintLayout>(R.id.controller_layout)
                controllerLayout?.findViewById<AppCompatImageButton>(R.id.exo_ffwd)?.run {
                    this.setImageResource(0)

                }
                controllerLayout?.findViewById<AppCompatImageButton>(R.id.exo_rew)?.run {
                    this.setImageResource(0)

                }
            }

            CastButtonFactory.setUpMediaRouteButton(
                this@PlayerActivity,
                getMenu(),
                R.id.mob_action_cast
            )
            getPlayerView()?.subtitleView?.apply {
                this.setBottomPaddingFraction(FLOAT_ZERO_POINT_ZERO_EIGHT)
                setApplyEmbeddedStyles(false)
                setFixedTextSize(
                    TypedValue.COMPLEX_UNIT_SP,
                    if (isMobile()) FLOAT_TWENTY_FOUR else FLOAT_THIRTY
                )
                setStyle(
                    CaptionStyleCompat(
                        Color.WHITE,
                        Color.TRANSPARENT,
                        Color.TRANSPARENT,
                        CaptionStyleCompat.EDGE_TYPE_DROP_SHADOW,
                        Color.BLACK, null
                    )
                )
            }
            setPlaybackSpeedClickListener { playbackSpeed ->
                showPlaySpeedDialog(
                    playbackSpeed,
                    getMenu()?.findItem(R.id.mob_action_play_speed)?.actionView!!
                )
            }
            getMenu()?.findItem(R.id.action_pip)?.setOnMenuItemClickListener {
                enterPiPMode()
                return@setOnMenuItemClickListener true
            }


            getMenu()?.findItem(R.id.mob_action_play_speed)?.isVisible =
                content.objectType != ObjectType.CHANEL

        }
    }

    private fun showPlaySpeedDialog(playbackSpeed: Float, findItem: View) {
        val adapter: ArrayAdapter<String> = ArrayAdapter<String>(
            this@PlayerActivity, R.layout.item_playerspeed_dialog, speedArr!!
        )
        val myMsg = TextView(this)
        myMsg.apply {
            text = getString(R.string.playbackspeed).uppercase(Locale.ENGLISH)
            setFontFamily(R.font.gotham_bold)
            textSize = 14F
            setPadding(8, 12, 8, 10)
            gravity = Gravity.CENTER_HORIZONTAL
        }
        alertDialog =
            AlertDialog.Builder(
                this@PlayerActivity,
                if (isTablet()) R.style.AppTheme_PlayerSpeedDialogTabTheme else R.style.AppTheme_PlayerSpeedDialogTheme
            )
                .setCustomTitle(myMsg)
                .setSingleChoiceItems(
                    adapter,
                    (if (playbackSpeed.equals(1F)) speedArr?.indexOf(getString(R.string.normal)) else speedArr?.indexOf(
                        playbackSpeed.toString().plus("x")
                    ))!!
                ) { dialog, which ->
                    exoPlayerView.setPlaybackSpeed(
                        (if (speedArr?.get(which) == getString(R.string.normal)) 1F else speedArr?.get(
                            which
                        )?.replace(
                            "x",
                            ""
                        )?.toFloat())!!
                    )
                    findItem.findViewById<TextView>(R.id.text_speed)?.apply {
                        this.typeface = ResourcesCompat.getFont(context, R.font.font_medium)
                        this.textSize = 10F
                        if (speedArr?.get(which) == getString(R.string.normal)) {
                            this.text = ""
                            this.visibility = View.GONE
                        } else {
                            this.text = speedArr?.get(which).toString()
                            this.visibility = View.VISIBLE
                            this.setBackgroundColor(resources.getColor(R.color.c_red_6))
                            this.alpha = 0.5F
                            this.setPadding(8, 0, 8, 0)
                        }
                    }
                    dialog.dismiss()
                }.show()
        val window: Window = alertDialog?.getWindow()!!
        val wlp: WindowManager.LayoutParams = window.attributes
        wlp.gravity = Gravity.RIGHT
        wlp.flags = wlp.flags and WindowManager.LayoutParams.FLAG_DIM_BEHIND.inv()
        window.attributes = wlp
        //alertDialog?.window?.setLayout(width, height)
    }

    /**
     * Set player listener
     *
     * @author Ratnesh Kumar Ratan
     * @since 26/3/20
     *
     * @modifier Ashik
     * @since 20/07/2020
     * */
    @Suppress("TooGenericExceptionCaught")
    private fun initStateListener() {
        Log.e("Player", "initStateListener: ")
        Log.e("Player", "initStateListener2: ")
        Log.e("Player intialized ", "" + ::exoPlayer.isInitialized)
        if (::exoPlayer.isInitialized)
            exoPlayer.setOnStateListener(object : StateListener<Content> {
                override fun onPlayerInitialized(t: Content?) {
                    setPlayerListener()
                    playerAnalyticsListener?.setSeekProcessListener(seekProcessListener)
                    watchTimer = WatchTimer()
                    AnalyticsProvider.getInstance()?.getTracker()?.pageView(
                        TrackerConstant.SCREEN_PLAYER, t?.title
                    )
                    t?.watchedDuration?.let {
                        updateWatchedDuration(it)
                    }
                    handleSkip(t)

                }

                override fun onPlayerReleased(t: Content?, position: Long, state: State?) {
                    Log.e(TAG, "onPlayerReleased: ")
                    playerAnalyticsListener?.removeSeekProcessListener()
                    val duration = t?.duration!! * ONE_THOUSAND
                    val percentage = (position.toDouble() / duration) * HUNDRER
                    val status =
                        if (state == State.End || percentage.toInt() > NINTYFIVE) {
                            //isWatchedCompltely = true
                            Constants.STATUS_COMPLETED
                        } else Constants.STATUS_IN_PROGRESS
                    t?.let {
                        //streamUnLock(t)
                        nextEpisodeId = try {
                            if (it.episodeNum.isNotNull() && exoPlayer.provider().hasNext())
                                exoPlayer.provider()
                                    .getMedia(exoPlayer.provider().index() + 1).id
                            else
                                null
                        } catch (exception: ArrayIndexOutOfBoundsException) {
                            null
                        } catch (exception: NullPointerException) {
                            null
                        }
                        if (it.objectType != ObjectType.CHANEL && !it.isTrailer) {

                            Log.e(TAG, "onPlayerReleased: ")

                            val map: MutableMap<String, Any> = mutableMapOf()
                            map.run {
                                put("watchedDuration", (position / ONE_THOUSAND))
                                put("status", status)
                                put("content", Gson().toJson(it))

                            }
                            Log.e(TAG, "onPlayerReleased: ${map.toString()}")

                            channel.invokeMethod("updateWatchedPercentage", map)
                        }
                    }
                    AnalyticsProvider.getInstance()?.getTracker()?.contentViewEvents(
                        STOP,
                        contentID = exoPlayer.provider().getMedia()?.t?.objectid,
                        contentType = exoPlayer.provider().getMedia()?.t?.objectType?.name,
                        contentTitle = exoPlayer.provider().getMedia()?.t?.title,
                        genre = exoPlayer.provider().getMedia()?.t?.genre,
                        contentCategory = exoPlayer.provider().getMedia()?.t?.category?.name,
                        playDuration = exoPlayer.provider().getMedia()?.t?.duration.toString(),
                        seasonNumber = exoPlayer.provider().getMedia()?.t?.seasonNum.toString(),
                        episodeNumber = exoPlayer.provider().getMedia()?.t?.episodeNum.toString()
                    )
                    if (t.episodeNum.isNotNull()) {
                        CoroutineScope(Dispatchers.IO).launch {
                            /* presenter().getContentData(
                                 t.objectid,
                                 additionalParams = createAdditionalParamForDetailApi(),
                                 success = {
                                     t.seriesName = it.seriesName
                                     watchedAnalyticsEvent(
                                         t,
                                         PlaybackType.STREAMING,
                                         position,
                                         state
                                     )
                                 }
                             ) {
                                 watchedAnalyticsEvent(t, PlaybackType.STREAMING, position, state)
                             }*/
                        }
                    } else watchedAnalyticsEvent(t, PlaybackType.STREAMING, position, state)
                    stopFingerPrinting()
                }
            })
    }

    /**

     * This function is to be called only in the onPlayerInitialized method

     * of exoPlayer.setOnStateListener() callback method.
     */

    private fun setPlayerListener() {
        lastSeenSubtitleLanguage = null
        lastUsedAudioLanguage = null

        exoPlayer.player()?.addListener(object : Player.EventListener {

            override fun onIsPlayingChanged(isPlaying: Boolean) {

                if (isPlaying) {
                    if (playerSeekCheck == true) {
                        playerSeekCheck = false
                    } else {
                        //setStream(false)
                    }
                    //false
                } else {
                    //stopStream()
                    // true
                }
                super.onIsPlayingChanged(isPlaying)
            }

            override fun onTracksChanged(
                trackGroups: TrackGroupArray,
                trackSelections: TrackSelectionArray
            ) {
                for (i in 0 until trackSelections.length) {
                    val format = trackSelections[i]?.selectedFormat
                    val fLanguage = displayLanguage(format?.language)
                    if (format?.containerMimeType?.contains("text") == true &&
                        fLanguage != lastSeenSubtitleLanguage
                    ) {
                        lastSeenSubtitleLanguage = fLanguage
                    }
                    if (format?.containerMimeType?.contains("audio") == true &&
                        fLanguage != lastUsedAudioLanguage
                    ) {
                        lastUsedAudioLanguage = fLanguage
                    }
                }

            }

        })

    }


    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            window.decorView.systemUiVisibility = flagFullScreen
        }
    }

    /*override fun dispatchKeyEvent(event: KeyEvent?): Boolean {
        return binding.exoPlayerView.dispatchKeyEvent(event) || super.dispatchKeyEvent(event)
    }*/


    companion object {


        const val EXTRA_CONTENT = "PlayerActivity.extra_content"
        private val TAG = PlayerActivity::class.java.simpleName
        private const val SD_MAX = 720

        var mPipMode: Boolean? = false
        private const val DEFAULT_MIN_BUFFER_MS = 2500
        private const val DEFAULT_MAX_BUFFER_MS = 3000
        private const val DEFAULT_BUFFER_FOR_PLAYBACK_MS = 2000
        private const val DEFAULT_BUFFER_FOR_PLAYBACK_AFTER_RE_BUFFER_MS = 2000
        private const val SKIP_TYPE_CREDITS_END: Int = 1004
        private const val SKIP_TYPE_CREDITS_START: Int = 1003
        private const val SKIP_TYPE_INTRO_END: Int = 1002
        private const val SKIP_TYPE_INTRO_START: Int = 1001
        private const val REQUEST_PLAY = 1
        private const val REQUEST_PAUSE = 2
        private const val REQUEST_FORWARD = 3
        private const val REQUEST_BACKWARD = 4
        private const val CONTROL_TYPE_PLAY = 1
        private const val CONTROL_TYPE_PAUSE = 2
        private const val CONTROL_TYPE_FORWARD = 3
        private const val CONTROL_TYPE_BACKWARD = 4
        private const val ACTION_MEDIA_CONTROL = "media_control"
        private const val EXTRA_CONTROL_TYPE = "control_type"


        var flagFullScreen = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
    }

    override fun onUserLeaveHint() {
        enterPiPMode(true)

    }

    private fun enterPiPMode(userLeaveHint: Boolean = false) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                if (packageManager.hasSystemFeature(PackageManager.FEATURE_PICTURE_IN_PICTURE)) {
                    mPipMode = true
                    stopFingerPrinting()
                    hideViews()
                    mPictureInPictureParamsBuilder?.setAspectRatio(Rational(16, 9))?.build()
                    bindPipActions()
                    mPictureInPictureParamsBuilder?.let {
                        enterPictureInPictureMode(mPictureInPictureParamsBuilder?.build()!!)
                    }
                    pictureInPictureModeReceiver()
                } else {
                    if (!userLeaveHint) toast(getString(R.string.pip_support_error))
                }
                audioFocusGain()
            } else {
                if (!userLeaveHint) toast(getString(R.string.pip_support_error))
            }
        } catch (excp: IllegalStateException) {
            //Log.v("PIP_MODE",excp.message.toString())
        }
    }

    private fun bindPipActions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            if (exoPlayer.player()?.isPlaying == true) {
                updatePictureInPictureActions(
                    R.drawable.ic_pause,
                    getString(R.string.pip_pause),
                    CONTROL_TYPE_PAUSE,
                    REQUEST_PAUSE
                )
            } else {
                updatePictureInPictureActions(
                    R.drawable.ic_play,
                    getString(R.string.pip_play),
                    CONTROL_TYPE_PLAY,
                    REQUEST_PLAY
                )
            }
    }

    /**
     * update the actions for PIP view
     *
     **/
    @RequiresApi(Build.VERSION_CODES.O)
    fun updatePictureInPictureActions(
        @DrawableRes iconId: Int, title: String?, controlType: Int, requestCode: Int
    ) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val actions = java.util.ArrayList<RemoteAction>()
                val intent = PendingIntent.getBroadcast(
                    this@PlayerActivity,
                    requestCode, Intent(ACTION_MEDIA_CONTROL).putExtra(
                        EXTRA_CONTROL_TYPE,
                        controlType
                    ), if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                    } else {
                        PendingIntent.FLAG_UPDATE_CURRENT
                    }
                )
                val icon: Icon = Icon.createWithResource(this@PlayerActivity, iconId)
                val forwardintent = PendingIntent.getBroadcast(
                    this@PlayerActivity,
                    REQUEST_FORWARD,
                    Intent(ACTION_MEDIA_CONTROL).putExtra(
                        EXTRA_CONTROL_TYPE,
                        CONTROL_TYPE_FORWARD
                    ), if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                    } else {
                        PendingIntent.FLAG_UPDATE_CURRENT
                    }
                )
                val backwardintent = PendingIntent.getBroadcast(
                    this@PlayerActivity,
                    REQUEST_BACKWARD,
                    Intent(ACTION_MEDIA_CONTROL).putExtra(
                        EXTRA_CONTROL_TYPE,
                        CONTROL_TYPE_BACKWARD
                    ), if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                    } else {
                        PendingIntent.FLAG_UPDATE_CURRENT
                    }
                )
                val forwardIcon: Icon = Icon.createWithResource(
                    this@PlayerActivity,
                    R.drawable.cast_ic_mini_controller_forward30
                )
                val backwardIcon: Icon = Icon.createWithResource(
                    this@PlayerActivity,
                    R.drawable.cast_ic_mini_controller_rewind30
                )
                if (content.objectType != ObjectType.CHANEL)
                    actions.add(
                        RemoteAction(
                            backwardIcon,
                            getString(R.string.pip_rewind),
                            getString(R.string.pip_rewind),
                            backwardintent
                        )
                    )
                actions.add(RemoteAction(icon, title!!, title, intent))
                if (content.objectType != ObjectType.CHANEL)
                    actions.add(
                        RemoteAction(
                            forwardIcon,
                            getString(R.string.pip_forward),
                            getString(R.string.pip_forward),
                            forwardintent
                        )
                    )
                mPictureInPictureParamsBuilder?.setActions(actions)
                setPictureInPictureParams(mPictureInPictureParamsBuilder?.build()!!)
            }
        } catch (exp: IllegalStateException) {
            //Log.v("PIP_MODE",exp.message.toString())
        }
    }

    private fun stopFingerPrinting() {

        //Check fingerprint is enabled.
        if (true/*prefManager.appConfig?.featureEnabled != null &&
            prefManager.appConfig?.featureEnabled?.hasFingerPrint == true*/
        ) {
            //overlayJob?.cancel()
            FingerPrintHandler.cancel()
        }
    }

    fun hideViews() {
        binding.textFingerPrint.hide()
        binding.exoPlayerView.getPlayerView()?.controllerAutoShow = false
        binding.exoPlayerView.getPlayerView()?.hideController()
        btnSkipIntro.hide()
        binding.nextEpisodeBtnLayout.root.hide()
        binding.nextEpisodeImageLayout.hide()
        binding.txtSecurity.hide()
    }


    @RequiresApi(Build.VERSION_CODES.O)
    override fun onPictureInPictureModeChanged(
        isInPictureInPictureMode: Boolean
    ) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode)
        if (isInPictureInPictureMode) {
            mPipMode = true
            hideViews()
            binding.imageWatermarkTop.hide()
            binding.imageWatermarkBottom.hide()
            exoPlayerView.getPlayerView()?.subtitleView.hide()

        } else {
            mPipMode = false
            exoPlayerView.getPlayerView()?.controllerAutoShow = true
            exoPlayerView.getPlayerView()?.showController()
            exoPlayerView.getPlayerView()
                ?.findViewById<ConstraintLayout>(R.id.controller_layout)?.show()
            binding.txtSecurity.show()
            binding.imageWatermarkTopSmall.hide()
            binding.imageWatermarkBottomSmall.hide()
            exoPlayerView.getPlayerView()?.subtitleView.show()
            if (/*prefManager.appConfig?.featureEnabled?.isPlayerWatermarkEnabled == true*/true) {
                try {
                    if (/*prefManager.appConfig?.providerDetails?.playerWatermark?.get("position")*/content.objectType != ObjectType.CHANEL) {
                        binding.imageWatermarkTop.show()
                        binding.imageWatermarkTop.setImageResource(R.drawable.ic_watermark_logo)
                        binding.imageWatermarkTop.alpha =
                                /*prefManager.appConfig?.providerDetails?.playerWatermark?.get("alpha")
                                    ?.toFloat()
                                    ?:*/ 0.4f
                    } else if (/*prefManager.appConfig?.providerDetails?.playerWatermark?.get("position") == "bottom"*/false) {
                        binding.imageWatermarkBottom.show()
                        binding.imageWatermarkBottom.setImageResource(R.drawable.ic_watermark_logo)
                        binding.imageWatermarkBottom.alpha =
                                /*prefManager.appConfig?.providerDetails?.playerWatermark?.get("alpha")
                                    ?.toFloat()
                               ?: */0.4f
                    }
                } catch (exp: java.lang.Exception) {
                    //do nothing
                }
            }

        }
    }

    private fun pictureInPictureModeReceiver() {
        mReceiver = object : BroadcastReceiver() {
            @RequiresApi(Build.VERSION_CODES.O)
            override fun onReceive(context: Context, intent: Intent) {
                if (intent == null
                    || ACTION_MEDIA_CONTROL != intent.action
                ) {
                    return
                }
                when (intent.getIntExtra(EXTRA_CONTROL_TYPE, 0)) {
                    CONTROL_TYPE_PLAY -> {

                        //streamLock(exoPlayer.provider().getMedia()?.t)
                        updatePictureInPictureActions(
                            R.drawable.ic_pause,
                            getString(R.string.pip_pause),
                            CONTROL_TYPE_PAUSE,
                            REQUEST_PAUSE
                        )
                        exoPlayer.resume()
                        hideViews()

                    }

                    CONTROL_TYPE_PAUSE -> {
                        //pausePlayer = true
                        // stopStream()
                        //streamUnLock(exoPlayer.provider().getMedia()?.t)
                        updatePictureInPictureActions(
                            R.drawable.ic_play,
                            getString(R.string.pip_play),
                            CONTROL_TYPE_PLAY,
                            REQUEST_PLAY
                        )
                        exoPlayer.pause()
                        hideViews()
                    }

                    CONTROL_TYPE_FORWARD -> {
                        exoPlayer.player()
                            ?.seekTo(exoPlayer.player()?.currentPosition?.plus(Constants.TIME_DELAY_TEN_MIN)!!)
                        hideViews()
                    }

                    CONTROL_TYPE_BACKWARD -> {
                        exoPlayer.player()
                            ?.seekTo(exoPlayer.player()?.currentPosition?.minus(Constants.TIME_DELAY_TEN_MIN)!!)
                        hideViews()
                    }
                }
            }
        }
        registerReceiver(mReceiver, IntentFilter(ACTION_MEDIA_CONTROL))
    }

    /**
     * Call the Stream api to lock the stream for this device.
     *
     * @param objectId
     */
    /*private fun streamLock(content: Content?) {
        if (content == null) return
        if (prefManager.appConfig?.featureEnabled?.isConcurrencyEnabled != true) return
        if (content.isTrailer) return
        if (streamLockJob != null) return
        if (isOfflineContent) return
        streamLockJob = lifecycleScope.launch {
            tickerFlow(TimeUnit.MINUTES.toMillis(3), content.objectid).cancellable().collect {
                presenter().setStream(it, success = {}, error = {
                    lifecycleScope.launch {
                        showAlertDialog()
                    }
                })
            }
        }
    }*/

    /**
     * Call the stream unlock api to remove the lock.
     *
     * @param objectId
     */
    /* private fun streamUnLock(content: Content?) {
         if (content == null) return
         if (prefManager.appConfig?.featureEnabled?.isConcurrencyEnabled != true) return
         if (isOfflineContent) return
         if (content.isTrailer) return
         streamLockJob?.cancel()
         streamLockJob = null
         CoroutineScope(Dispatchers.IO).launch {
             presenter().unsetStream(content.objectid, success = {}, error = {})
         }
     }*/

    private fun audioFocusGain() {
        val mAudioManager = this.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val playbackAttributes = AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_MEDIA)
            .setContentType(AudioAttributes.CONTENT_TYPE_MOVIE)
            .build()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            mAudioManager.requestAudioFocus(
                AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN)
                    .setAudioAttributes(playbackAttributes)
                    .setAcceptsDelayedFocusGain(true)
                    .setOnAudioFocusChangeListener(audioFocusChangeListener)
                    .build()
            )
        } else {
            //do nothing
        }
    }

    override fun onDestroy() {
        if (mReceiver.isNotNull()) {
            unregisterReceiver(mReceiver)
            mReceiver = null
        }
        if (
            alertDialog.isNotNull())
            alertDialog?.dismiss()
        //content = null
        /*downloadedList.clear()
        playListItems = null*/
        super.onDestroy()
    }

    private fun handleSkipActionButtonVisibility(eventTime: AnalyticsListener.EventTime) {
        val skipList = exoPlayer.provider().getMedia()?.t?.skip
        if (skipList.isNullOrEmpty()) return
        val skipIntro = skipList.find { it.skiptype == Skip.SkipPlayer.INTRO }
        val skipCredits = skipList.find { it.skiptype == Skip.SkipPlayer.CREDITS }
        if (skipIntro != null) {
            val endMs = skipIntro.end!!.toMs()
            val startMs = skipIntro.start!!.toMs()
            if (btnSkipIntro.isVisible &&
                eventTime.currentPlaybackPositionMs >= endMs ||
                eventTime.currentPlaybackPositionMs <= startMs
            ) binding.btnSkipIntro.hide()
            if (!btnSkipIntro.isVisible &&
                eventTime.currentPlaybackPositionMs < endMs &&
                eventTime.currentPlaybackPositionMs >= startMs &&
                exoPlayer.player()?.playWhenReady == true
            ) btnSkipIntro.show()
        }
        if (skipCredits != null) {
            val startMs = skipCredits.start!!.toMs()
            if (!binding.nextEpisodeBtnLayout.root.isVisible &&
                eventTime.currentPlaybackPositionMs >= startMs
                && exoPlayer.provider().hasNext()
            ) showNextContentButton()
        }

    }

    private fun handleSkip(content: Content?) {
        btnSkipIntro.hide()
        binding.nextEpisodeBtnLayout.root.hide()
        if (content == null || content.skip.isNullOrEmpty()) return
        val skipIntro = content.skip?.find { it.skiptype == Skip.SkipPlayer.INTRO }
        val skipCredits = content.skip?.find { it.skiptype == Skip.SkipPlayer.CREDITS }
        val handler = Handler()
        if (skipIntro != null) {
            exoPlayer.player()?.createMessage(this)
                ?.setHandler(handler)
                ?.setType(SKIP_TYPE_INTRO_START)
                ?.setPayload(skipIntro)
                ?.setPosition(skipIntro.start!!.toMs())
                ?.setDeleteAfterDelivery(false)
                ?.send()
            exoPlayer.player()?.createMessage(this)
                ?.setHandler(handler)
                ?.setType(SKIP_TYPE_INTRO_END)
                ?.setPayload(skipIntro)
                ?.setPosition(skipIntro.end!!.toMs())
                ?.setDeleteAfterDelivery(false)
                ?.send()
        }
        if (skipCredits != null) {
            exoPlayer.player()?.createMessage(this)
                ?.setHandler(handler)
                ?.setType(SKIP_TYPE_CREDITS_START)
                ?.setPayload(skipCredits)
                ?.setPosition(skipCredits.start!!.toMs())
                ?.setDeleteAfterDelivery(false)
                ?.send()
        }
    }

    private fun showNextContentButton() {
        val content = exoPlayer.provider()
            .getMedia()?.t
        if (objectAnimator?.isRunning == false) {
            objectAnimator?.duration = Constants.TIME_DELAY_TEN_MIN
            objectAnimator?.start()
        }
        val text_view_button = binding.nextEpisodeBtnLayout.textViewButton
        if (content?.tags.checkCTMusicTag()) {
            text_view_button.text = resources.getString(R.string.next_track)
        } else if (content?.tags.checkCTShortsTag()) {
            text_view_button.text = resources.getString(R.string.next_video)
        } else if (content?.isTrailer == false && content.seriesid.isNull()) {
            text_view_button.text = resources.getString(R.string.next_movie)
        } else if (content?.isTrailer == false && content.seriesid.isNotNull()) {
            text_view_button.text = resources.getString(R.string.next_episode)
        }
        episodeCancelFlag = false
        binding.nextEpisodeBtnLayout.root.show()
        //Log.v("NEXT_EPISODE_VISIBLE", "true")
    }


    private fun skipIntoInit() {
        val button_progress_bar = binding.nextEpisodeBtnLayout.buttonProgressBar
        objectAnimator = ObjectAnimator.ofInt(
            button_progress_bar,
            "progress",
            button_progress_bar.progress,
            Constants.HUNDRER
        ).setDuration(Constants.TIME_DELAY_TEN_MIN)
        objectAnimator?.addUpdateListener { valueAnimator ->
            val progress = valueAnimator.animatedValue as Int
            button_progress_bar.progress = progress
        }
        objectAnimator?.doOnEnd {
            if (!episodeCancelFlag!! && binding.nextEpisodeBtnLayout.root.visibility == View.VISIBLE) {
                binding.nextEpisodeBtnLayout.root.hide()
                objectAnimator?.cancel()
                if (exoPlayer.provider().hasNext()) {
                    playNextContentDirectly()
                }
            }
        }
        btnSkipIntro.setOnClickListener {
            exoPlayer.provider().getMedia()?.t?.skip?.let { skipDetails ->
                val skipIntro =
                    skipDetails.find { it.skiptype == Skip.SkipPlayer.INTRO }
                exoPlayer.player()?.seekTo(
                    skipIntro?.end!!.toMs()
                )
            }
        }
        binding.nextEpisodeBtnLayout.textViewButton.setOnClickListener {
            objectAnimator?.end()
        }
        binding.nextEpisodeBtnLayout.btnCancelNextEpisode.setOnClickListener {
            episodeCancelFlag = true
            binding.nextEpisodeBtnLayout.root.hide()
        }
    }

    private fun playNextContentDirectly() {
        try {
            if (exoPlayer.provider().peek() == exoPlayer.provider().getMedia()) {
                nextMediaIndex =
                    playListItems?.indexOf(exoPlayer.provider().peek().t)?.plus(1)
            } else {
                nextMediaIndex = if (playListItems?.size == 1) 1 else null
                if (isFirstTimeAutoPlay) {
                    exoPlayer.provider().moveToNext()
                    isFirstTimeAutoPlay = false
                }
            }
        } catch (e: ArrayIndexOutOfBoundsException) {
            // FirebaseCrashlytics.getInstance().recordException(e)
        } catch (e: NoSuchElementException) {
            // FirebaseCrashlytics.getInstance().recordException(e)
        }
        try {
            if (::exoPlayer.isInitialized)
                playNextVideo()
        } catch (e: NoSuchElementException) {
            if (!playListClosedByUser && !playListItems.isNullOrEmpty())
                binding.playListView.show()
        } catch (e: ArrayIndexOutOfBoundsException) {
            // do nothing
        }
    }

    private fun playNextVideo() {
        //stopStream()
        exoPlayer.apply {
            val index = if (nextMediaIndex != null && nextMediaIndex != -1) {
                nextMediaIndex!!
            } else {
                provider().index()
            }
            checkAvailability(index, seasonNo)
            nextMediaIndex = null

        }

    }

    /**
     * Get content stream for particular content and handle subscription and purchases
     * @param index [Int]
     * @param seasonNo [Int]
     * @author Ratnesh Kumar Ratan
     * @since 29/10/2020
     */
    private fun checkAvailability(index: Int, seasonNo: Int) {
        if (::exoPlayer.isInitialized) {
            var mContent = exoPlayer.provider().getMedia(index).t

            Log.e(TAG, "checkAvailability: " + mContent.toString())
            mContent?.contentStream?.let {
                mContent.playContent()
                return
            }

            //send the related content to play(to flutter code)
            val map: MutableMap<String, Any> = mutableMapOf()
            map.run {
                put("content", Gson().toJson(mContent))

            }
            channel.invokeMethod("playRelatedContent", map)


            /*lifecycleScope.launch {
                presenter().getContentDetails(
                    mContent?.objectid,
                    additionalParams = createAdditionalParamForDetailApi(),
                    success = { content ->
//                        if (profileType(
//                                subscriberData?.subscriberId,
//                                subscriberData?.profileId,
//                                subscriberData?.kidsMode
//                            ) == Constants.KID && content?.defaultgenre != Constants.GENRE_KIDS
//                        ) {
//                            showAlertDialog(getString(R.string.message_content_permission_denied_for_kids))
//                        } else {
                        mContent = content
                        mContent?.availabilityCheck(
                            userAvailability,
                            presenter().getCountry(),
                            openPlanListener = { unAvailableIdSet ->
                                this@PlayerActivity.index = index
                                this@PlayerActivity.seasonNo = seasonNo
                                openPlanPage(unAvailableIdSet, mContent!!)
                            },
                            contentStreamApiListener = { finalAvailabilityId, packageId ->
                                fetchStreamInfo(mContent!!, finalAvailabilityId, packageId)
                            },
                            screenSize = when {
                                is4K() -> ContentQuality.ULTRAHD
                                isHd() -> ContentQuality.HD
                                else -> ContentQuality.SD
                            },
                            openPurchaseDialog = { unAvailableIdSet, isSubscribable ->
                                this@PlayerActivity.index = index
                                this@PlayerActivity.seasonNo = seasonNo
                                showPurchaseDialog(
                                    unAvailableIdSet,
                                    isSubscribable,
                                    mContent!!
                                )
                            }
                        )
                        // }
                    }, error = {
                        onError(it)
                    }
                )
            }*/
        }
    }

    override fun handleMessage(messageType: Int, payload: Any?) {
        when (messageType) {
            SKIP_TYPE_INTRO_START -> {
                btnSkipIntro.show()
            }

            SKIP_TYPE_INTRO_END -> {
                btnSkipIntro.hide()
            }

            SKIP_TYPE_CREDITS_START -> {
                if (exoPlayer.provider().hasNext())
                    showNextContentButton()
            }

            SKIP_TYPE_CREDITS_END -> {
            }
        }
    }

    /**
     *  Check for next content play
     *
     * @author Ratnesh Kumar Ratan
     * @since 17/05/2021
     * */
    @Suppress("TooGenericExceptionCaught")
    private fun playNextContent() {
        try {
            //stopStream()
            if (exoPlayer.provider().peek() == exoPlayer.provider().getMedia()) {
                nextMediaIndex =
                    playListItems?.indexOf(exoPlayer.provider().peek().t)?.plus(1)
                nextMediaIndex?.let {
                    exoPlayerView?.showAutoPlay(exoPlayer.provider().getMedia(it))
                        .also {
                            AnalyticsProvider.getInstance()?.getTracker()?.trackScreen(
                                this@PlayerActivity, TrackerConstant.SCREEN_NEXT_OVERLAY
                            )
                        }
                }
            } else {
                nextMediaIndex = null
                if (isFirstTimeAutoPlay) {
                    exoPlayer.provider().moveToNext()
                    isFirstTimeAutoPlay = false
                }

                showNextContentDetails()
            }
        } catch (e: ArrayIndexOutOfBoundsException) {
            // FirebaseCrashlytics.getInstance().recordException(e)
        } catch (e: NoSuchElementException) {
            //  FirebaseCrashlytics.getInstance().recordException(e)
        }
    }

    private fun showNextContentDetails() {
        if (nextEpisodeImageLayout.visibility != View.VISIBLE) {
            nextEpisodeImageLayout.show()
            binding.autoPlayView?.findViewById<AppCompatButton>(R.id.auto_cancel)?.visibility =
                View.INVISIBLE
        }
        if (::exoPlayer.isInitialized) {
            exoPlayer.apply {
                val index = if (nextMediaIndex != null && nextMediaIndex != -1) {
                    nextMediaIndex!!
                } else {
                    provider().index()
                }
                val content = provider().getMedia(index).t
                GlideApp.with(this@PlayerActivity).load(content?.poster(Orientation.LANDSCAPE))
                    .into(binding.image)
                binding.image.setOnClickListener {
                    binding.autoPlayView.findViewById<View>(R.id.auto_play).performClick()
                    nextEpisodeImageLayout.hide()
                }
                binding.txtNextTitle.text =
                    if (content?.seasonNum.isNotNull() && content?.episodeNum.isNotNull() && !content?.tags.checkCTMusicTag() && !content?.tags.checkCTShortsTag()) getString(
                        R.string.series_title,
                        content?.seasonNum ?: "",
                        content?.episodeNum ?: ""
                    ).plus(Constants.BLANK_SPACE)
                        .plus(content?.title) else content?.title
                binding.txtNextEpisodeHeader.apply {
                    object :
                        CountDownTimer(Constants.TIME_DELAY_TEN_MIN, Constants.TIME_DELAY_ONE_MIN) {
                        override fun onTick(millisUntilFinished: Long) {
                            var startIndex = 0
                            var endIndex = 0
                            val nextTxt =
                                if (content?.tags.checkCTMusicTag()) {
                                    getString(
                                        R.string.next_track_starts_after,
                                        (millisUntilFinished / ONE_THOUSAND).toString()
                                    )
                                } else if (content?.tags.checkCTShortsTag()) {
                                    getString(
                                        R.string.next_video_starts_after,
                                        (millisUntilFinished / ONE_THOUSAND).toString()
                                    )
                                } else if (content?.seasonNum.isNotNull() && content?.episodeNum.isNotNull()) {
                                    getString(
                                        R.string.next_episode_starts_after,
                                        (millisUntilFinished / ONE_THOUSAND).toString()
                                    )
                                } else {
                                    getString(
                                        R.string.next_movie_starts_after,
                                        (millisUntilFinished / ONE_THOUSAND).toString()
                                    )
                                }
                            if (content?.tags.checkCTMusicTag()) {
                                startIndex = if (prefManager.appLanguage == SHORT_MAR) 11 else 24
                                endIndex =
                                    if (prefManager.appLanguage == SHORT_MAR) 19 else nextTxt.length
                            } else if (content?.seasonNum.isNotNull() && content?.episodeNum.isNotNull()) {
                                startIndex = if (prefManager.appLanguage == SHORT_MAR) 13 else 26
                                endIndex =
                                    if (prefManager.appLanguage == SHORT_MAR) 21 else nextTxt.length
                            } else if (content?.tags.checkCTShortsTag()) {
                                startIndex = if (prefManager.appLanguage == SHORT_MAR) 14 else 24
                                endIndex =
                                    if (prefManager.appLanguage == SHORT_MAR) 22 else nextTxt.length
                            } else {
                                startIndex = if (prefManager.appLanguage == SHORT_MAR) 14 else 24
                                endIndex =
                                    if (prefManager.appLanguage == SHORT_MAR) 22 else nextTxt.length
                            }
                            try {
                                val redSpannable = SpannableString(nextTxt)
                                redSpannable.setSpan(
                                    ForegroundColorSpan(
                                        ContextCompat.getColor(
                                            this@PlayerActivity,
                                            R.color.c_jazz_berry_2
                                        )
                                    ), startIndex, endIndex, 0
                                )
                                text = redSpannable
                            } catch (exp: java.lang.Exception) {
                                //do nothing
                            }
                        }

                        override fun onFinish() {
                        }
                    }.start()

                }
            }

        }
    }

    /**
     * Add default content stream to all playlist items
     * later when click listener on playlist will handle availability
     *
     * @author Ratnesh Kumar Ratan
     * @since 29/10/2020
     * */
    private fun bindPlayListContentStreams() {
        try {
            if (::exoPlayer.isInitialized)
                playListItems?.let { exoPlayer.provider().addAll(it) }
            binding.playListView.apply {
                if (playListType is PlayListType.PlayListNormal) {
                    initPLayListAdapter()
                    playListAdapter?.let { adapter -> setAdapter(adapter) }
                    setUpPlayerListener()
                    exoPlayerView?.setPlaylistEnabled(playListItems?.isNotEmpty() == true)
                }
            }
        } catch (exp: Exception) {
            //do nothing
        }
    }

    /**
     * Init playlist adapter
     **/
    private fun initPLayListAdapter() {
        try {
            if (::exoPlayer.isInitialized)
                playListAdapter =
                    CustomPlayListAdapter(
                        exoPlayer.provider(),
                        playListType is PlayListType.PlayListSeries,
                        getTagLocal
                    )
        } catch (exception: NullPointerException) {
            //do nothing
        }
    }

    /**
     * SetUp player listener like Playlist,Menu,state etc
     *
     * @modifier Ashik
     * @since 20/07/2020
     * */
    private fun setUpPlayerListener() {
        exoPlayerView?.setUpWithPlayListView(binding.playListView)
        initPlayListVisibility()
        initPlayListItemClickListener()
        initPlayerMenuAction()
        initPlayerStateListener()
    }

    /**
     * Init playlist visibility listener
     *
     * @author Ratnesh Kumar Ratan
     * @since 26/3/20
     *
     * @modifier Ashik
     * @since 20/07/2020
     *
     * @modifier Ratnesh Kumar Ratan
     * @since 19/05/2021
     * */
    private fun initPlayListVisibility() {
        binding.playListView.addOnPlayListVisibilityListener {

            binding.txtSecurity.isVisible=!it
            val content = exoPlayer.provider().getMedia()?.t
            if (::exoPlayer.isInitialized)
                when {
                    it && content?.isTrailer == true -> {
                        /* sendPlayPauseEvent(content)
                         sendPausedEvent(content, true)*/
                    }

                    it && content?.isTrailer == false -> {
                        /*sendPlayPauseEvent(content)
                        sendPausedEvent(content, false)*/
                    }

                    !it && exoPlayer.isPlayerInitialized() && binding.progressBar?.isVisible == false -> {
                        /* sendResumedEvent(content)
                         sendPlayResumeEvent(content)*/
                        exoPlayer.resume()
                    }

                    !it && exoPlayer.isPlayerInitialized() && binding.progressBar?.isVisible == true -> {
                        exoPlayer.initPlayer()
                        exoPlayerView.setTile(
                            exoPlayer.provider().getMedia()?.title
                                ?: getString(R.string.app_name)
                        )
                    }

                    else -> {
                        // do nothing
                    }
                }
        }
    }

    /**
     * Init playlist item click events
     *
     * @author Ratnesh Kumar Ratan
     * @since 26/3/20
     *
     * @modifier Ashik
     * @since 20/07/2020
     * */
    private fun initPlayListItemClickListener() {
        binding.playListView?.setOnItemClickListener { index, seasonNo ->
            if (this.seasonNo != seasonNo)
                this.seasonNo = seasonNo
            isFirstTimeAutoPlay = false
            checkAvailability(index, seasonNo)
        }
    }

    fun bindSeasons(map: Map<Content, List<Content>>) {
        if (::exoPlayer.isInitialized)
            exoPlayer.provider().clear()

        if (map.isNotEmpty()) {
            if (::exoPlayer.isInitialized)
                bindSeasonMap(map)
            initSeasonAdapter(map)
            exoPlayerView?.setPlaylistEnabled(true)
        } else exoPlayerView?.setPlaylistEnabled(false)
    }

    /**
     * Bind season number and content list
     *
     * @author Ratnesh Kumar Ratan
     * @since 19/05/2021
     **/
    private fun bindSeasonMap(map: Map<Content, List<Content>>) {
        var isPlayListIconEnabled = false
        map.forEach { entry ->
            if (!isPlayListIconEnabled && entry.value.isNotEmpty()) {
                isPlayListIconEnabled = true
            }
            exoPlayer.provider().set(list = entry.value, season = entry.key.seasonNum!!)
            if (entry.key.seasonNum == exoPlayer.provider().seasonNo()) {
                val indexOfCurrent = entry.value.indexOfFirst {
                    it.objectid == exoPlayer.provider().getMedia()?.t?.objectid
                }
                if (indexOfCurrent != -1) {
                    this.seasonNo = entry.key.seasonNum!!
                    exoPlayer.provider()
                        .setIndex(indexOfCurrent, entry.key.seasonNum!!)
                }
            }
        }
    }

    /**
     * Init season adapter
     *
     * @author Ratnesh Kumar Ratan
     * @since 17/05/2021
     **/
    private fun initSeasonAdapter(map: Map<Content, List<Content>>) {
        binding.playListView.findViewById<TextView>(R.id.season_title)?.text =
            LocaleHelper.switchLocale(applicationContext)?.getString(R.string.season)
        if (playListType is PlayListType.PlayListSeries) {
            val text_season_name =
                binding.playListView.findViewById<TextView>(R.id.text_season_name)

            text_season_name.text = content?.title ?: EMPTY_STRING
            binding.playListView.findViewById<Group>(R.id.season_container).visibility =
                View.VISIBLE
            seasonRecyclerView =
                binding.playListView.findViewById<RecyclerView>(R.id.recycler_view_season)
            LocaleHelper.switchLocale(this@PlayerActivity)?.getString(R.string.episodes)
                ?.let {
                    binding.playListView?.setTitle(it)
                }

            seasonAdapter = SeasonAdapter().apply {
                onSeasonClick { currentSeason ->
                    playListClosedByUser = false
                    binding.playListView.switchSeason(currentSeason.toInt())
                    notifyDataSetChanged()
                }
            }
            if (::seasonAdapter.isInitialized) {
                val seasonsList: List<Content> = map.keys.asSequence().map {
                    it.isChecked = it.seasonNum == exoPlayer.provider().seasonNo(); it
                }.sortedByDescending { it.seasonNum }.toList()

                seasonAdapter.submitList(seasonsList)
                if (::seasonRecyclerView.isInitialized)
                    seasonRecyclerView.adapter = seasonAdapter
            }
            initPLayListAdapter()
            //Set adapter to PlayList
            playListAdapter?.let { binding.playListView?.setAdapter(it) }
            setUpPlayerListener()
        }
    }


    private fun initPlayerMenuAction() {
        exoPlayerView?.setOnMenuActionListener {
            when (it) {
                ExoPlayerView.MenuAction.PlayList -> {
                    binding.playListView?.show().also {
                        playListAdapter?.notifyDataSetChanged()
                    }
                }

                ExoPlayerView.MenuAction.Settings -> {
                    if (::exoPlayer.isInitialized) {
                        AnalyticsProvider.getInstance()?.getTracker()?.trackScreen(
                            this@PlayerActivity,
                            TrackerConstant.SCREEN_PLAYER_SETTINGS
                        )
                        exoPlayer.pause()

                        val trackSelector = exoPlayer.getTrackSelector()
                        if (trackSelector == null || !TrackSelection.willHaveContent(
                                trackSelector
                            )
                        ) {
                            return@setOnMenuActionListener
                        }
                        val trackDialog = TrackSelectionDialog.createForTrackSelector(
                            trackSelector,
                            exoPlayer.player()?.videoFormat,
                            exoPlayer.player()?.audioFormat,
                            null
                        )
                        trackDialog.setOnDismissListener {
                            exoPlayer.resume()
                            // sendAnalytics()
                        }
                        trackDialog.show(supportFragmentManager, null)
                    }
                }

                ExoPlayerView.MenuAction.Cast -> {
                }
            }
        }
    }

    /**
     * @author ashik
     * @since 30-10-2020
     *
     * Play content with season and index
     */
    private fun Content.playContent() {
        val index = exoPlayer.provider().immutableList()
            .indexOfFirst { it?.objectid == this.objectid }
        if (index != -1) {
            exoPlayer.release()
            exoPlayer.provider().set(this@playContent, index, seasonNo)
                .setIndex(index, seasonNo)
                .moveToNext()
            exoPlayer.clearStartPosition()
            exoPlayer.initPlayer()
            exoPlayerView.setTile(
                exoPlayer.provider().getMedia(index).title
                    ?: getString(R.string.app_name)
            )
             if (playListType is PlayListType.PlayListSeries) {
                 binding.playListView.apply {
                     this.findViewById<TextView>(R.id.text_season_name).text =
                         this@playContent.title
                 }
             }
        } else {
            //Non-fatal
            //FirebaseCrashlytics.getInstance().recordException(IndexOutOfBoundsException("Content not present with this index"))
        }
    }

    /**
     * Sends data to the analytics Provider to send the data to respective trackers.
     *
     * @param content [Content] instance
     * @param playbackType [PlaybackType] instance
     * @param state [State] instance.
     */
    @Suppress("SameParameterValue")
    private fun watchedAnalyticsEvent(
        content: Content?,
        playbackType: PlaybackType,
        duration: Long,
        state: State?
    ) {
        try {
            watchTimer?.compute()
            val durationInSec = TimeUnit.MILLISECONDS.toSeconds(duration)
            // Calculating the 90% of duration from the content duration
            val percentValue = (content?.duration?.toDouble() ?: Constants.ZERO_POINT_ZERO) *
                    Constants.ZERO_POINT_NINE
            /*AnalyticsProvider.getInstance()?.getTracker()
                ?.playWatchedEvent(
                    content,
                    playbackType,
                    startPosition,
                    duration,
                    watchTimer?.getWatchTime() ?: Constants.LONG_ZERO,
                    durationInSec > percentValue || state == State.End,
                    intent?.getStringExtra(SOURCE) ?: EMPTY_STRING,
                    presenter().getSubscriberCountry(),
                    dayOfWeek(),
                    timeInUtcFormat(),
                    languageFullForm(lastUsedAudioLanguage ?: EMPTY_STRING),
                    languageFullForm(lastSeenSubtitleLanguage ?: EMPTY_STRING),
                    getString(com.api.R.string.platform),
                    if (isMobile()) MOBILE_ else TABLET_
                )*/
            watchTimer?.reset()
        } catch (exp: Exception) {
            //do nothing
        }
    }

    fun updateWatchedDuration(duration: Long) {
        try {
            if (::exoPlayer.isInitialized && exoPlayer.provider().isNotNull()) {
                duration.let {
                    exoPlayer.seekTo(it)
                    startPosition = it
                    AnalyticsProvider.getInstance()?.getTracker()?.playStartedEvent(
                        exoPlayer.provider().getMedia()?.t,
                        PlaybackType.STREAMING,
                        it
                    )
                }
                if (!exoPlayer.provider().getList().isNullOrEmpty())
                    exoPlayerView?.setPlaylistEnabled(
                        exoPlayer.provider()
                            .getList().size > 1
                    )

                if (exoPlayer.provider().getMedia()?.t?.isTrailer == true) {
                    AnalyticsProvider.getInstance()?.getTracker()?.trailerViewEvents(
                        ApiConstant.START,
                        contentID = exoPlayer.provider().getMedia()?.t?.objectid,
                        contentTitle = exoPlayer.provider().getMedia()?.t?.title,
                        genre = exoPlayer.provider().getMedia()?.t?.genre,
                        contentCategory = exoPlayer.provider().getMedia()?.t?.category?.name,
                        quality = when {
                            is4K() -> ContentQuality.ULTRAHD.name
                            isHd() -> ContentQuality.HD.name
                            else -> ContentQuality.SD.name
                        }
                    )
                } else {
                    AnalyticsProvider.getInstance()?.getTracker()?.contentViewEvents(
                        ApiConstant.START,
                        contentID = exoPlayer.provider().getMedia()?.t?.objectid,
                        contentType = exoPlayer.provider().getMedia()?.t?.objectType?.name,
                        packageID = exoPlayer.provider().getMedia()?.t?.contentStream?.packageid,
                        contentTitle = exoPlayer.provider().getMedia()?.t?.title,
                        genre = exoPlayer.provider().getMedia()?.t?.genre,
                        contentCategory = exoPlayer.provider().getMedia()?.t?.category?.name,
                        seasonNumber = exoPlayer.provider().getMedia()?.t?.seasonNum.toString(),
                        episodeNumber = exoPlayer.provider().getMedia()?.t?.episodeNum.toString(),
                        playbackMode = PlaybackType.STREAMING.name,
                        playStartPosition = startPosition.toString(),
                        resumedFromPrevSession = null,
                        referredFrom = null
                    )
                }
            }
        } catch (exception: NullPointerException) {
            //do nothing
        }
    }

    /** Cast session listener */
    private inner class CastSessionAvailabilityListener : SessionManagerListener<Session> {
        override fun onSessionStarted(p0: Session, p1: String) {
            if (!::exoPlayer.isInitialized) return
            val playbackPositionMs: Long
            val playWhenReady: Boolean
            val playbackState = exoPlayer.player()?.playbackState
            if (playbackState != Player.STATE_ENDED) {
                playbackPositionMs = exoPlayer.player()?.currentPosition ?: 0
                playWhenReady = exoPlayer.player()?.playWhenReady ?: false
                if (content?.isTrailer == true) {
                    /* createTrailerCastMediaItem(
                         playbackPositionMs,
                         playWhenReady,
                         presenter().getSubscriber()
                     )*/
                } else {

                    var requestBody =
                        "drmscheme=${content.contentStream?.drmscheme?.first()}&availabilityid=" +
                                "${content.contentStream?.availabilityId}&seclevel=5677&offline=NO&contentid=${content.objectid}&packageid=${content.contentStream?.packageid}"

                    getDRMToken(requestBody, intent.getStringExtra("sessionToken")) { token ->
                        runOnUiThread {
                            createCastMediaItem(
                                playbackPositionMs,
                                playWhenReady,
                                token,
                                "Subscriberid"
                            )
                        }
                    }


                }

            }
        }


        override fun onSessionResumeFailed(p0: Session, p1: Int) {
            //no op
        }

        override fun onSessionSuspended(p0: Session, p1: Int) {
            //no op
        }

        override fun onSessionEnded(p0: Session, p1: Int) {
            //no op
        }

        override fun onSessionResumed(p0: Session, p1: Boolean) {
            //no op
        }

        override fun onSessionStarting(p0: Session) {
            //no op
        }

        override fun onSessionResuming(p0: Session, p1: String) {
            //no op
        }

        override fun onSessionEnding(p0: Session) {
            //no op
        }

        override fun onSessionStartFailed(p0: Session, p1: Int) {
            //no op
        }
    }


    /**
     * Create cast media item
     **/
    private fun createCastMediaItem(
        positionMs: Long,
        playWhenReady: Boolean,
        drmToken: String?,
        subscriberId: String?
    ) {
        if (!::exoPlayer.isInitialized) return
        val item = exoPlayer.provider().getMedia()?.t?.buildMediaQueueItem(
            this,
            drmToken,
            intent.getStringExtra("sessionToken"),
            subscriberId
        )
        if (item != null) {
            initRmClient()?.let { rmClient ->
                startCast(item, positionMs, playWhenReady, rmClient)
                finish()
            }

        }
    }

    /**
     * Crate trailer cast media item
     **/
    private fun createTrailerCastMediaItem(
        positionMs: Long,
        playWhenReady: Boolean, subscriberId: String?
    ) {
        createCastMediaItem(positionMs, playWhenReady, null, subscriberId)
    }

    fun initRmClient(): RemoteMediaClient? {
        return sessionManager?.currentCastSession?.remoteMediaClient
    }


}