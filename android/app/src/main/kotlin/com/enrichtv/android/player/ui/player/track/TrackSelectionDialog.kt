/** This class provide dialog for track selection **/
package com.enrichtv.android.ui.player.track

import android.content.DialogInterface
import android.os.Bundle
import android.util.SparseArray
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager.LayoutParams
import androidx.fragment.app.DialogFragment
import com.enrichtv.android.R
import com.google.android.exoplayer2.C
import com.google.android.exoplayer2.Format
import com.google.android.exoplayer2.source.TrackGroupArray
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector.SelectionOverride
import com.google.android.exoplayer2.trackselection.MappingTrackSelector.MappedTrackInfo
import com.enrichtv.android.databinding.DialogTrackSelectionBinding
import com.enrichtv.android.player.ui.player.exo.TrackSelectionView
import com.enrichtv.android.ui.player.exo.PlayerTrackNameProvider
import com.enrichtv.android.util.LocaleHelper
import com.enrichtv.android.util.getDeviceHeight
import com.enrichtv.android.util.getDeviceWidth
import com.enrichtv.android.util.hide

/**
 * @author Ratnesh Kumar Ratan
 * @since 04/04/2020
 *
 * @modified Ashik
 * @since @since 20/05/2020
 */

class TrackSelectionDialog private constructor() : DialogFragment() {

    /*private var availableTrackGroups = 0*/

    /**
     * Initial track parameters
     */
    private var initialParameters: DefaultTrackSelector.Parameters? = null

    /**
     * [MappedTrackInfo]
     */
    private var mappedTrackInfo: MappedTrackInfo? = null

    /**
     * Array which stores [TrackSelectionView] parameters
     */
    private val trackArray: SparseArray<TrackSelectionView> = SparseArray()

    /*private lateinit var qualityTrack: TrackSelectionView
    private lateinit var audioTrack: TrackSelectionView
    private lateinit var subTitleTrack: TrackSelectionView*/

    private var allowAdaptiveSelections = false
    private var allowMultipleOverrides = false
    private var showDisableOption = false

    private var videoFormat: Format? = null
    private var audioFormat: Format? = null
    private var textFormat: Format? = null
    private var dismissListener: ((Boolean) -> Unit)? = null

    private var dialogDismissListener: DialogInterface.OnDismissListener? = null

    companion object {

        private val TAG = "TrackSelectionDialog"

        /**
         * Method for Create [TrackSelectionDialog] instance
         * @param trackSelector [DefaultTrackSelector] instance
         * @param allowMultipleOverrides
         * @param allowAdaptiveSelections
         * @param showDisableOption
         * @return [TrackSelectionDialog] instance
         *
         * @author Ashik
         * @since 20/05/2020
         * */
        fun createForTrackSelector(
            trackSelector: DefaultTrackSelector,
            videoFormat: Format?, audioFormat: Format?, textFormat: Format?,
            allowMultipleOverrides: Boolean = false,
            allowAdaptiveSelections: Boolean = false,
            showDisableOption: Boolean = false
        ): TrackSelectionDialog {
            val trackSelectionDialog = TrackSelectionDialog()
            val mappedTrackInfo = trackSelector.currentMappedTrackInfo!!
            val parameters = trackSelector.parameters
            trackSelectionDialog.init(
                mappedTrackInfo,
                parameters,
                allowMultipleOverrides,
                allowAdaptiveSelections,
                showDisableOption,
                videoFormat, audioFormat, textFormat,
                DialogInterface.OnDismissListener {
                    val builder = parameters.buildUpon()
                    for (i in 0 until mappedTrackInfo.rendererCount) {
                        val trackType = mappedTrackInfo.getRendererType(i)
                        if (isAllowedToOverride(trackType)) {
                            builder.clearSelectionOverrides(i)
                                .setRendererDisabled(i, trackSelectionDialog.getIsDisabled(i))
                            val overrides: List<SelectionOverride> =
                                trackSelectionDialog.getOverrides(i)
                            if (overrides.isNotEmpty()) {
                                builder.setSelectionOverride(
                                    i,
                                    mappedTrackInfo.getTrackGroups(i),
                                    overrides[0]
                                )
                            }
                        }
                    }
                    trackSelector.setParameters(builder)
                }
            )
            return trackSelectionDialog
        }

        /**
         * Overrides the default value only if it matches the [dialogType] & [trackType]
         *
         * @param trackType Either [C.TRACK_TYPE_VIDEO] or [C.TRACK_TYPE_AUDIO] or [C.TRACK_TYPE_TEXT]
         * @param dialogType Either [DIALOG_SETTINGS] or [DIALOG_SUBTITLE]
         * @return true if allowed; false otherwise
         *
         * @author Ashik
         * @since 20/05/2020
         */
        private fun isAllowedToOverride(trackType: Int): Boolean {
            return when (trackType) {
                C.TRACK_TYPE_VIDEO, C.TRACK_TYPE_AUDIO, C.TRACK_TYPE_TEXT -> {
                    true
                }
                else -> false
            }
        }

        const val dialogSystemUiVisibility = (View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        LocaleHelper.switchLocale(requireContext())
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NORMAL, R.style.TrackSelectionDialog)
    }

    lateinit var dialogTrackSelectionBinding: DialogTrackSelectionBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {


        dialogTrackSelectionBinding =
            DialogTrackSelectionBinding.inflate(inflater, container, false)


        dialog?.setCanceledOnTouchOutside(true)
        dialog?.window?.setFlags(LayoutParams.FLAG_NOT_FOCUSABLE, LayoutParams.FLAG_NOT_FOCUSABLE)
        dialog?.window?.addFlags(LayoutParams.FLAG_ALT_FOCUSABLE_IM or LayoutParams.FLAG_KEEP_SCREEN_ON)
        dialog?.window?.decorView?.systemUiVisibility = dialogSystemUiVisibility

        dialog?.window?.setGravity(Gravity.CENTER_HORIZONTAL or Gravity.CENTER_VERTICAL)
        return dialogTrackSelectionBinding.root
    }

    init {
        retainInstance = true
    }

    /**
     * Init method
     *
     * @param mappedTrackInfo [MappedTrackInfo] instance
     * @param initialParameters [DefaultTrackSelector.Parameters]
     * @param allowMultipleOverrides Default false
     * @param allowAdaptiveSelections Default false
     * @param showDisableOption Default false
     * @param dismissListener Dismiss listener
     *
     * @author Ashik
     * @since 20/05/2020
     */
    private fun init(
        mappedTrackInfo: MappedTrackInfo,
        initialParameters: DefaultTrackSelector.Parameters,
        allowMultipleOverrides: Boolean = false,
        allowAdaptiveSelections: Boolean = false,
        showDisableOption: Boolean = false,
        videoFormat: Format?, audioFormat: Format?, textFormat: Format?,
        dismissListener: DialogInterface.OnDismissListener
    ) {
        this.mappedTrackInfo = mappedTrackInfo
        this.initialParameters = initialParameters
        this.allowMultipleOverrides = allowMultipleOverrides
        this.allowAdaptiveSelections = allowAdaptiveSelections
        this.showDisableOption = showDisableOption
        this.dialogDismissListener = dismissListener
        this.videoFormat = videoFormat
        this.audioFormat = audioFormat
        this.textFormat = textFormat
    }

    override fun onDismiss(dialog: DialogInterface) {
        super.onDismiss(dialog)
        dialogDismissListener?.onDismiss(dialog)
        dismissListener?.invoke(true)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        dialogTrackSelectionBinding.buttonClose?.setOnClickListener { dismiss() }

        initViews()
    }

    override fun onResume() {

        val params: LayoutParams = dialog!!.window!!.attributes
        val deviceWidth = context?.getDeviceWidth()
        val deviceHeight = context?.getDeviceHeight()
        val defaultMarginHorizontal = 26
        val defaultMarginVertical = 20

        params.height = deviceHeight?.minus(
            deviceHeight.times(defaultMarginHorizontal).div(100)
        ) ?: 0
        params.width = deviceWidth?.minus(
            deviceWidth.times(defaultMarginVertical/*.times(availableTrackGroups/2)*/).div(100)
        ) ?: 0

        dialog!!.window!!.attributes = params
        dialog?.window?.clearFlags(LayoutParams.FLAG_NOT_FOCUSABLE)
        super.onResume()
    }

    private fun Int.isVideoTrack() = this == C.TRACK_TYPE_VIDEO
    private fun Int.isAudioTrack() = this == C.TRACK_TYPE_AUDIO
    private fun Int.isTextTrack() = this == C.TRACK_TYPE_TEXT


    /**
     * Render Track UIs according to renderIndex and dialogType
     *
     * @author Ashik
     * @since 20/05/2020
     */
    private fun initViews() {
        dialogTrackSelectionBinding.labelQuality?.text =
            LocaleHelper.switchLocale(requireContext())?.getString(R.string.quality)
        dialogTrackSelectionBinding.labelLanguage?.text =
            LocaleHelper.switchLocale(requireContext())?.getString(R.string.audio)
        dialogTrackSelectionBinding.labelSubTitle?.text =
            LocaleHelper.switchLocale(requireContext())?.getString(R.string.subtitles)
        mappedTrackInfo?.run {
            for (renderIndex in 0 until rendererCount) {
                when (val trackType = getRendererType(renderIndex)) {
                    C.TRACK_TYPE_VIDEO, C.TRACK_TYPE_AUDIO, C.TRACK_TYPE_TEXT -> {
                        /*if (showTrackGroupForRender(this, renderIndex, trackType)) {*/
                        /*availableTrackGroups += 1*/
                        initTrackView(
                            this,
                            renderIndex,
                            if (trackType.isVideoTrack()) videoFormat else if (trackType.isAudioTrack()) audioFormat else null,
                            getTrackGroups(renderIndex),
                            if (trackType.isVideoTrack()) dialogTrackSelectionBinding.qualityTrack else if (trackType.isAudioTrack()) dialogTrackSelectionBinding.audioTrack else if (trackType.isTextTrack()) dialogTrackSelectionBinding.subTitleTrack else null
                        )
                        /*}*/
                    }

                }

            }
        }
    }

    private fun hideQualityTrack() {
        dialogTrackSelectionBinding.labelQuality?.hide()
        dialogTrackSelectionBinding.audioDivider?.hide()
    }

    private fun hideAudioTrack() {
        dialogTrackSelectionBinding.audioContainer?.hide()
    }

    private fun hideTextTrack() {
        dialogTrackSelectionBinding.subTitleContainer?.hide()
        dialogTrackSelectionBinding.textDivider?.hide()
    }


    private fun showTrackGroupForRender(
        mappedTrackInfo: MappedTrackInfo?,
        renderIndex: Int, trackType: Int
    ): Boolean {
        return true
        hideAudioTrack()
        val trackGroupArray = mappedTrackInfo?.getTrackGroups(renderIndex)
        if (trackGroupArray?.length ?: 0 == 0) {
            when (trackType) {
                C.TRACK_TYPE_VIDEO -> hideQualityTrack()
                C.TRACK_TYPE_AUDIO -> hideAudioTrack()
                C.TRACK_TYPE_TEXT -> hideTextTrack()
            }
            return false
        }
        return true
    }

    /**
     * Initialize the tracks
     *
     * @param mappedTrackInfo [MappedTrackInfo] instance
     * @param renderIndex render index of track group (Video quality,Audio,Subtitle)
     * @param trackGroupArray [TrackGroupArray]
     * @param track [TrackSelectionView] instance to render UI
     *
     * @author Ashik
     * @since 20/05/2020
     */
    private fun initTrackView(
        mappedTrackInfo: MappedTrackInfo,
        renderIndex: Int,
        format: Format?,
        trackGroupArray: TrackGroupArray,
        track: TrackSelectionView?
    ) {
        track ?: return
        var isDisabled = initialParameters?.getRendererDisabled(renderIndex) ?: false
        val isSubTitle = track == dialogTrackSelectionBinding.subTitleTrack
        val isVideo = track == dialogTrackSelectionBinding.qualityTrack
        val isAudio = track == dialogTrackSelectionBinding.audioTrack
        if (isSubTitle || isAudio) {
            track.setShowAutoOption(false)
            if (mappedTrackInfo.getTrackGroups(renderIndex).isEmpty) {
                isDisabled = true
            }
        } else if (isVideo) {
            track.setMinVideoQuality(0)
        }
        trackArray.put(renderIndex, track)

        val overrides = initialParameters?.getSelectionOverride(renderIndex, trackGroupArray)

        track.apply {
            setAllowMultipleOverrides(allowMultipleOverrides)
            setAllowAdaptiveSelections(allowAdaptiveSelections)
            if (isSubTitle) {
                setShowDisableOption(true)
            } else {
                setShowDisableOption(showDisableOption)
            }
            /*   if (isVideo) {
                   setShowAutoOption(true)
               } else {
                   setShowAutoOption(false)
               }*/
            setTrackNameProvider(PlayerTrackNameProvider(LocaleHelper.switchLocale(requireContext())!!))
            init(
                mappedTrackInfo,
                renderIndex,
                isDisabled,
                format,
                if (overrides == null) emptyList() else listOf(overrides),
                null
            )
        }
    }

    /**
     * Dialog dismiss listener
     */
    fun setOnDismissListener(listener: (Boolean) -> Unit) {
        this.dismissListener = listener
    }

    /**
     * Returns the [SelectionOverride] value for the [rendererIndex]
     *
     * @param rendererIndex Renderer index
     * @return list of [SelectionOverride] else empty list
     *
     * @author Ashik
     * @since 20/05/2020
     */
    private fun getOverrides(rendererIndex: Int): List<SelectionOverride> {
        val trackSelectionView = trackArray[rendererIndex]
        return if (trackSelectionView != null) trackSelectionView.overrides else emptyList()
    }

    /**
     * Returns whether the track selection is disabled or not.
     *
     * @param rendererIndex Renderer index
     * @return true if disabled; false otherwise
     *
     * @author Ashik
     * @since 20/05/2020
     */
    private fun getIsDisabled(rendererIndex: Int): Boolean {
        val trackSelectionView = trackArray[rendererIndex]
        return trackSelectionView != null && trackSelectionView.isDisabled
    }
}
