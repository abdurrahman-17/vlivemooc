//
//  PlayerControlsView.swift
//  MOBIPlayer
//
//  Created by Sasikumar on 30/07/19.
//  Copyright © 2019 Sasikumar. All rights reserved.
//

import UIKit
import AVKit
#if MOBIRELEASE
import MOBIPlayerRelease
#endif
#if MOBIDEBUG
import MOBIPlayer
#endif
class PlayerControlsView: MOBIPlayerControlsView, AVRoutePickerViewDelegate {
    @IBOutlet weak var currentTimeLabel: UILabel?
    @IBOutlet weak var durationLabel: UILabel?
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var liveDotImageView: UIImageView!
    @IBOutlet weak var backArrow: UIImageView!
    @IBOutlet weak var fullscreenButton: UIButton? {
        didSet {
            fullscreenButton?.supportOrientation = 1
        }
    }
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var airPlayView: UIView!
    @IBOutlet weak var pictureInPictureButton: UIButton!
    @IBOutlet weak var liveView: UIView!
    override var settingsButton: UIButton? {
        didSet {
            settingsButton?.supportOrientation = 2
        }
    }
    override var forwardButton: MOBIQuickSeekButton? {
        didSet {
            forwardButton?.supportOrientation = 2
        }
    }
    @IBOutlet weak var minimizeButton: UIButton! {
        didSet {
            minimizeButton?.supportOrientation = 2
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton?.supportOrientation = 1
        }
    }
    @IBOutlet weak var chromeCastButton: UIButton! {
        didSet {
            chromeCastButton?.supportOrientation = 2
        }
    }
    @IBOutlet weak var playbackSpeedButton: UIButton!
    var returnAirplayChanged: ((Bool) -> Void)?
    public func setUI() {
        currentTimeLabel?.font = Font.regularH3.value
        durationLabel?.font = Font.regularH3.value
        liveLabel.textColor = .white
        liveLabel.font = Font.semiBoldH4.value
        liveLabel.text = HardCodedText.live.localized.uppercased()
        self.updateAllButtonImages(self)
        self.backArrow.image = backArrow.image?.imageFlippedForRightToLeftLayoutDirection().withRenderingMode(.alwaysTemplate)
        self.backArrow.tintColor = .white
        self.slider?.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.3)
        addBadgeViewUI()
        disableRTL()
        addAirPlayButton()
    }
    override func updateTime(_ totalDuration: Float, currentDuration: Float) {
        super.updateTime(totalDuration, currentDuration: currentDuration)
        liveView.isHidden = !isLiveStreaming
        currentTimeLabel?.isHidden = isLiveStreaming
        currentTimeLabel?.text = "\(timeFormatted(currentDuration))"
        durationLabel?.text = "\(timeFormatted(isLiveStreaming ? currentDuration : totalDuration))"
    }
    override func updateQuickSeekButtons() {
        super.updateQuickSeekButtons()
        forwardButton?.isHidden = isLiveStreaming
        backwardButton?.isHidden = isLiveStreaming
    }
//    override func showHideGoLiveButton(_ canShow: Bool) {
//        liveLabel.text = canShow ? HardCodedText.goLive.localized : HardCodedText.live.localized.uppercased()
//    }
    private func addBadgeViewUI() {
        self.badgeView.roundCorners(radius: 2)
        self.badgeView.backgroundColor = Color.brandColor.value.withAlphaComponent(0.6)
        speedLabel?.textColor = .white
        speedLabel?.font = Font.boldTag.value
        speedLabel?.sizeToFit()
    }
    func configurePictureInPicture() {
        pictureInPictureButton.isHidden = !AVPictureInPictureController.isPictureInPictureSupported()
        pictureInPictureButton.setImage(UIImage(named: "PictureInPicture")?.withRenderingMode(.alwaysTemplate), for: .normal)
        pictureInPictureButton.tintColor = .white
    }
    private func disableRTL() {
        self.bottomView?.semanticContentAttribute = .forceLeftToRight
        self.slider?.semanticContentAttribute = .forceLeftToRight
        self.slider?.subviews.forEach({ (view) in
            if view is UIProgressView {
                view.semanticContentAttribute = .forceLeftToRight
            }
        })
        self.currentTimeLabel?.semanticContentAttribute = .forceLeftToRight
        self.durationLabel?.semanticContentAttribute = .forceLeftToRight
        self.durationLabel?.superview?.semanticContentAttribute = .forceLeftToRight
        self.forwardButton?.superview?.semanticContentAttribute = .forceLeftToRight
    }
    private func adjustPlayerOrientation(_ tag: Int) {
        let value =  tag == 101 ? UIInterfaceOrientation.landscapeRight.rawValue : UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
    private func addAirPlayButton() {
        if #available(iOS 11.0, *) {
            let routerPickerView = AVRoutePickerView()
            routerPickerView.delegate = self
            routerPickerView.addViewTo(self.airPlayView)
            routerPickerView.tintColor = .white
            routerPickerView.activeTintColor = .white
            if #available(iOS 13.0, *) {
                routerPickerView.prioritizesVideoDevices = true
            }
            airPlayView.isHidden = false
        } else {
            airPlayView.isHidden = true
        }
    }
    private func updateAllButtonImages(_ mainView: UIView) {
        for view in mainView.subviews {
            if let button = view as? UIButton {
                button.imageView?.contentMode = .scaleAspectFit
            }
            self.updateAllButtonImages(view)
        }
    }
    @IBAction func liveButtonPressed(_ sender: UIButton) {
        self.goLiveButtonPressed()
    }
    @IBAction func minimizeFullScreenButtonPressed(_ sender: UIButton) {
        adjustPlayerOrientation(sender.tag)
    }
    @available(iOS 11.0, *)
    func routePickerViewWillBeginPresentingRoutes(_ routePickerView: AVRoutePickerView) {
        returnAirplayChanged?(true)
    }
    @available(iOS 11.0, *)
    func routePickerViewDidEndPresentingRoutes(_ routePickerView: AVRoutePickerView) {
        returnAirplayChanged?(false)
    }
    @IBAction func pictureInPicturePressed(_ sender: UIButton) {
        pictureInPictureButtonPressed()
    }
}
