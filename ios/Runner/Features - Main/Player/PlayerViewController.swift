//
//  PlayerViewController.swift
//  Runner
//
//  Created by Azeezulla Khan on 11/04/23.
//

import UIKit
#if MOBIRELEASE
import MOBIPlayerRelease
#endif

#if MOBIDEBUG
import MOBIPlayer
#endif
protocol PlayerViewControllerFlutterDelegate: AnyObject {
    func fetchFairplayCertificate() -> Data?
    func fetchWidevineLicense(with data: Data!, contentId: String!, completionBlock: ((Data?, Error?) -> Void)!)
    func fetchFairplayLicense(with data: Data!, contentId: String!) -> Data?
    func didPlaylistPressed()
    func didChromeCastPressed(content: Content?)
    func playerDidFailed(_ error: Error?)
}
class PlayerViewController: MOBIPlayerContainerViewController {
    private var playerControlsView: PlayerControlsView?
    var returnClosePressed: (() -> Void)?
    var returnContentProgress: ((Any?) -> Void)?
    private var currentState: PlayerState! = .idle {
        didSet {
            self.playerControlsView?.playbackSpeedButton.superview?.isHidden = currentState == .idle || currentState == .completed || controlsView?.isLiveStreaming == true
            if currentState == .ready {
                setSubtitleAudioFromPersistence()
            }
        }
    }
    private var pictureInPictureController: AVPictureInPictureController?
    weak var flutterDelegate: PlayerViewControllerFlutterDelegate?
    var content: Content?
    var defaultSubtitleLanguageCode: String?
    var persistedSettings: (audio: String?, subtitle: String?)?
    private var progressSendTimer: Timer?
    private var isTrailer: Bool = false
    private var canUpdateProgress: Bool = false
    var userEmailAndIP: String? = ""
    private var userEmailAndIpAndDateLable: UILabel?
    private var currentDateTimeTimer: Timer?
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        callInWillDisappear()
    }
    override func viewDidDisappear(_ animated: Bool) {
        callInDidDisappear()
    }
    // MARK: - Status bar and Orientation Related
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .bottom
    }
    override func showSettingsPopup() {
        guard self.currentState.rawValue >= PlayerState.ready.rawValue else { return }
        self.pause(true)
        self.hideControls(true)
        let settingsViewController = PlayerSettingsViewController(nibName: "PlayerSettingsViewController", bundle: Bundle(for: PlayerSettingsViewController.self))
        settingsViewController.modalTransitionStyle = .crossDissolve
        settingsViewController.modalPresentationStyle = .overCurrentContext
        settingsViewController.qualities = videoQualityStreams ?? [MOBIVideoQuality]()
        settingsViewController.audioLanguages = audioLanguages
        settingsViewController.embedSubtitles = embededSubtitles
        settingsViewController.sideLoadSubtitles = sideLoadSubtitles
        settingsViewController.selectedSettings = (self.selectedVideoQuality, self.selectedAudioLanguage, self.selectedEmbededSubtitle ?? self.selectedSideLoadSubtitle)
        settingsViewController.currentPresentationHeight = self.player?.currentItem?.presentationSize.height
        settingsViewController.returnDismiss = { [weak self] (settings) in
            self?.selectedVideoQuality = settings?.0
            self?.selectedAudioLanguage = settings?.1
            if let sideLoadedSubtitle = settings?.2 as? SideLoadSubtitle {
                self?.selectedSideLoadSubtitle = sideLoadedSubtitle
            }
            if let embedSubtitle = settings?.2 as? AVMediaSelectionOption {
                self?.selectedEmbededSubtitle = embedSubtitle
            }
            if settings?.2 == nil {
                self?.selectedSideLoadSubtitle = nil
                self?.selectedEmbededSubtitle = nil
            }
            self?.play(true)
        }
        self.present(settingsViewController, animated: false, completion: nil)
    }
    override func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        if isClearingPictureInPicture || !self.isRestorePictureInPicture {
            callInWillDisappear()
            callInDidDisappear()
        }
    }
    override func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        super.pictureInPictureController(pictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler: completionHandler)
    }
    // MARK: - Setup player
    private func setupPlayer() {
        self.view.backgroundColor = .black
        playerControlsView = PlayerControlsView(frame: self.view.bounds)
        playerControlsView?.returnAirplayChanged = { [weak self] (isOpened) in
            if isOpened {
                self?.pause(true)
            } else {
                self?.play(true)
            }
        }
        self.controlsView = playerControlsView
        self.skipCreditView = SkipCreditView(frame: CGRect(x: 0, y: 0, width: 100, height: 36))
        self.nextEpisodeButton = NextEpisodeButton(frame: CGRect(x: 0, y: 0, width: 100, height: 36))
#if MOBIRELEASE
        self.initialize("PlayerConfig-Release", bundle: Bundle(for: PlayerViewController.self), delegate: self, allowsExternalPlayback: true, hasRecordRestriction: false)
#endif
#if MOBIDEBUG
        self.initialize("PlayerConfig", bundle: Bundle(for: PlayerViewController.self), delegate: self, allowsExternalPlayback: true, hasRecordRestriction: false)
#endif
        playerControlsView?.closeButton.addTarget(self, action: #selector(self.closeButtonPressed(_:)), for: .touchUpInside)
        playerControlsView?.chromeCastButton?.addTarget(self, action: #selector(self.didChromeCastButtonPressed), for: .touchUpInside)
        playerControlsView?.playbackSpeedButton?.addTarget(self, action: #selector(self.didplaybackSpeedButtonPressed), for: .touchUpInside)
        playerControlsView?.setUI()
        setUserEmailAndIP()
        setLogo()
        startDateTimer()
        changeVideoGravity(.resizeAspect)
    }
    public func playTrailer(_ trailer: Trailer, trailerContent: Content?) {
        guard let videoURL = URL(string: trailer.filelist?.first?.filename ?? "") else { return }
        self.isTrailer = true
        self.playContent(MOBIContent(videoURL,
                                     title: trailerContent?.displayTitle ?? trailer.title,
                                     contentId: "",
                                     hasPictureInPicture: true))
    }
    public func playVideo(_ content: Content,
                          streamDetails: StreamDetails,
                          startDuration: Double?,
                          playLeadDuration: Int? = nil) {
        self.isTrailer = false
        playContent(content, streamDetails: streamDetails, startDuration: startDuration, playLeadDuration: playLeadDuration)
    }
    private func playContent(_ content: Content,
                             streamDetails: StreamDetails,
                             startDuration: Double?,
                             playLeadDuration: Int? = nil) {
        self.content = content
        self.updatePlaybackSpeed()
        self.refreshContentInfo(content)
        if let urlString = streamDetails.streamfilename, let videoURL = URL(string: urlString) {
            let seekThumbnail = self.createScrubbingModel(streamDetails)
            let nextEpisodeDuration: (Double, Double)? = content.fetchNextEpisode()
            let skipCreditDuration: (Double, Double)? = content.fetchSkipIntro()
            self.playContent(MOBIContent(videoURL, title: content.displayTitle,
                                         contentId: content.objectid ?? "",
                                         startDuration: startDuration ?? 0,
                                         audioContent: MOBIAudioContent(content.displayTitle, albumTitle: content.seriesname, image: content.fetchImageURL(.MIXED, imageSize: .zero)),
                                         skipCreditDuration: skipCreditDuration,
                                         nextEpisodeDuration: nextEpisodeDuration, hasPictureInPicture: true,
                                         seekThumbnail: seekThumbnail,
                                         clearLead: content.isClearLeadEnabled ? (true, Double(playLeadDuration ?? 0)) : nil))
        }
    }
    // MARK: - Controls View Actions
    @objc private func closeButtonPressed(_ button: UIButton) {
        didCloseButtonPressed()
    }
    @objc func didChromeCastButtonPressed() {
        self.pause(true)
        self.flutterDelegate?.didChromeCastPressed(content: self.content)
    }
    @objc private func didplaybackSpeedButtonPressed() {
        self.pause(true)
        let playbackSpeedViewController = PlaybackSpeedViewController(nibName: "PlaybackSpeedViewController", bundle: Bundle(for: PlaybackSpeedViewController.self))
        playbackSpeedViewController.selectedPlaybackRate = self.currentPlayerRate
        playbackSpeedViewController.modalTransitionStyle = .crossDissolve
        playbackSpeedViewController.modalPresentationStyle = .overCurrentContext
        playbackSpeedViewController.returnDidSelectPlaybackRate = { [weak self] (rate) in
            self?.updatePlaybackSpeed(rate)
        }
        self.present(playbackSpeedViewController, animated: false, completion: nil)
    }
}
extension PlayerViewController {
    private func refreshContentInfo(_ content: Content) {
        self.setThumbImage()
        self.controlsView?.updateTime(0, currentDuration: 0)
        self.controlsView?.slider?.setBufferProgress(progress: 0, animated: false)
        self.controlsView?.slider?.setValue(0, animated: false)
    }
    func setThumbImage() {
        if let url = URL(string: self.content?.fetchImageURL(.MIXED, imageSize: self.thumbImageView?.bounds.size ?? .zero) ?? "") {
            self.thumbImageView?.downloaded(from: url, contentMode: .scaleAspectFit)
            self.thumbImageView?.isHidden = self.currentState.rawValue >= PlayerState.ready.rawValue
        }
    }
    private func setSubtitleAudioFromPersistence() {
        if let language = persistedSettings {
            if let audioLanguageCode = language.audio {
                if let audio = audioLanguages.filter({ audio in
                    return audio.locale?.languageCode == audioLanguageCode
                }).first {
                    selectedAudioLanguage = audio
                }
            }
            if let subtitleLanguageCode = language.subtitle {
                if subtitleLanguageCode == "OFF" {
                    self.selectedSideLoadSubtitle = nil
                    self.selectedEmbededSubtitle = nil
                    return
                }
                if !embededSubtitles.isEmpty {
                    if let subtitle = embededSubtitles.filter({ subtitle in
                        return subtitle.locale?.languageCode == subtitleLanguageCode
                    }).first {
                        self.selectedEmbededSubtitle = subtitle
                        return
                    }
                }
                if !sideLoadSubtitles.isEmpty {
                    if let subtitle = sideLoadSubtitles.filter({ (option) -> Bool in
                        return option.languageCode == subtitleLanguageCode
                    }).first {
                        self.selectedSideLoadSubtitle = subtitle
                        return
                    }
                }
            }
        }
        setDefaultSubtitle()
    }
    private func setDefaultSubtitle() {
        if let defaultSubtitle = defaultSubtitleLanguageCode {
            if !embededSubtitles.isEmpty {
                if let subtitle = embededSubtitles.filter({ (option) -> Bool in
                    return option.locale?.identifier == defaultSubtitle
                }).first {
                    self.selectedEmbededSubtitle = subtitle
                }
            }
            if !sideLoadSubtitles.isEmpty {
                if let subtitle = sideLoadSubtitles.filter({ (option) -> Bool in
                    return option.languageCode == defaultSubtitle
                }).first {
                    self.selectedSideLoadSubtitle = subtitle
                }
            }
        }
    }
    private func setUserEmailAndIP() {
        userEmailAndIpAndDateLable = UILabel(frame: self.view.bounds)
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = df.string(from: Date())
        userEmailAndIpAndDateLable?.text = (self.userEmailAndIP ?? "") + "\n\(currentTime)"
        userEmailAndIpAndDateLable?.translatesAutoresizingMaskIntoConstraints = false
        userEmailAndIpAndDateLable?.numberOfLines = 0
        userEmailAndIpAndDateLable?.textColor = .white
        userEmailAndIpAndDateLable?.font = UIFont.systemFont(ofSize: 12)
        userEmailAndIpAndDateLable?.alpha = 0.8
        self.view.addSubview(userEmailAndIpAndDateLable!)
        let guide = self.view.safeAreaLayoutGuide
        userEmailAndIpAndDateLable?.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -50).isActive = true
        userEmailAndIpAndDateLable?.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8).isActive = true
    }
    private func setLogo() {
        guard self.content != nil && self.content?.category != "CHANEL" && self.content?.category != "LIVE" else { return }
        self.view.setNeedsLayout()
        let logoImageView = UIImageView(frame: self.view.bounds)
        logoImageView.image = UIImage(named: "ic_watermark_logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.alpha = 0.5
        self.view.addSubview(logoImageView)
        let guide = self.view.safeAreaLayoutGuide
        logoImageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 8).isActive = true
        logoImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
extension PlayerViewController {
    private func updatePlaybackSpeed(_ rate: Float = 1) {
        self.changePlaybackSpeed(rate)
        updateSpeedBadge(rate)
    }
    private func updateSpeedBadge(_ rate: Float) {
        self.playerControlsView?.badgeView.isHidden = rate == 1
        self.playerControlsView?.speedLabel.text = "\(rate)x"
    }
}
extension PlayerViewController: MOBIPlayerContainerViewControllerDelegate {
    func didUpdatePlayerState(_ state: PlayerState, player: AVPlayer?) {
        self.currentState = state
        switch state {
        case .paused:
            self.pushCurrentProgressToFlutter()
            self.stopProgressTimer()
            break
        case .playing:
            self.startProgressTimer()
        case .ready:
            self.startProgressTimer()
            self.canUpdateProgress = true
        default:
            break
        }
    }
    func didCloseButtonPressed() {
        self.pushCurrentProgressToFlutter()
        self.stopProgressTimer()
        self.dismiss(animated: true) {
            self.didDismiss()
        }
    }
    func didPlayListPressed() {
        self.pause(true)
        self.flutterDelegate?.didPlaylistPressed()
    }
    func playerDidFailed(_ error: Error?) {
        self.flutterDelegate?.playerDidFailed(error)
    }
    func didPlaybackStalled() {
    }
    func didShowActivityIndicator(_ isBuffering: Bool) {
        DispatchQueue.main.async { [weak self] in
            isBuffering ? self?.view.showLoader(.white) : self?.view.stopLoader()
        }
    }
    func fetchLicense(with data: Data!, contentId: String!, completionBlock: ((Data?, Error?) -> Void)!) {
        self.flutterDelegate?.fetchWidevineLicense(with: data, contentId: contentId, completionBlock: completionBlock)
    }
    func fetchAppCertificateData() -> Data? {
        return self.flutterDelegate?.fetchFairplayCertificate()
    }
    func contentKeyFromKeyServerModuleWithRequestData(_ requestBytes: Data, assetString: String) -> Data? {
        return self.flutterDelegate?.fetchFairplayLicense(with: requestBytes, contentId: assetString)
    }
    func didLoadNextEpisode() {
    }
    func didConfiguredPictureInPictureControl(_ controller: AVPictureInPictureController?) {
        self.pictureInPictureController = controller
        self.playerControlsView?.configurePictureInPicture()
        appDelegateObj?.player = self
    }
    func didManuallyTriggerPlayerPauseState(_ isPlay: Bool) {
    }
}
extension PlayerViewController {
    func callInWillDisappear() {
        guard !isPictureInPictureActive else { return }
        self.pause(true)
    }
    func callInDidDisappear() {
        guard !isPictureInPictureActive else { return }
    }
    func restorePictureInPicture() {
        self.pictureInPictureController?.stopPictureInPicture()
    }
    func didDismiss() {
        DispatchQueue.main.async {
            self.stopDateTimer()
            self.releasePlayer()
            appDelegateObj?.player = nil
            UIApplication.shared.endReceivingRemoteControlEvents()
        }
    }
    private func pushCurrentProgressToFlutter() {
        do {
            guard let content = self.content else { return }
            if content.category != "CHANEL" && content.category != "LIVE" && self.isTrailer == false && canUpdateProgress == true {
                let data = try JSONEncoder().encode(content)
                let contentJsonString = String(data: data, encoding: .utf8)
                let dictionary: [String: Any] = ["status": self.getCurrentProgress(), "watchedDuration": Int(self.currentPlayerTime), "content": contentJsonString ?? ""]
                self.returnContentProgress?(dictionary)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    private func getCurrentProgress() -> String {
        let watchedProgress = Float(self.currentPlayerTime)/Float(self.content?.duration ?? 0)
        if watchedProgress <= 95 {
            return "INPROGRESS"
        } else {
            return "COMPLETED"
        }
    }
}
extension PlayerViewController {
    private func startProgressTimer() {
        if self.progressSendTimer == nil {
            self.progressSendTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] timer in
                self?.pushCurrentProgressToFlutter()
            }
        }
    }
    func stopProgressTimer() {
        progressSendTimer?.invalidate()
        progressSendTimer = nil
    }
    private func startDateTimer() {
        if self.currentDateTimeTimer == nil {
            self.currentDateTimeTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] timer in
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let currentTime = df.string(from: Date())
                self?.userEmailAndIpAndDateLable?.text = "\(self?.userEmailAndIP ?? "") \n \(currentTime)"
            }
        }
    }
    private func stopDateTimer() {
        currentDateTimeTimer?.invalidate()
        currentDateTimeTimer = nil
    }
}
