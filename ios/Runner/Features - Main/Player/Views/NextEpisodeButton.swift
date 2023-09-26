//
//  NextEpisodeButton.swift
//  VLIVE
//
//  Created by Sasikumar on 31/05/21.
//  Copyright © 2021 Mobiotics. All rights reserved.
//

import UIKit
#if MOBIRELEASE
import MOBIPlayerRelease
#endif
#if MOBIDEBUG
import MOBIPlayer
#endif
class NextEpisodeButton: MOBINextEpisodeButton {
    override func commonInit() {
        super.commonInit()
        self.isRTL = Bundle.isLanguageRTL()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.closeButton?.roundCorners(radius: self.bounds.height / 2)
    }
    override func addNextEpisodeButton() {
        super.addNextEpisodeButton()
        self.nextEpisodeButton?.titleLabel?.font = Font.boldH3.value
        self.nextEpisodeButton?.backgroundColor = UIColor(hexString: "#B3B3B3")
        self.nextEpisodeButton?.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.nextEpisodeButton?.roundCorners(radius: 4)
        self.closeButton?.titleLabel?.font = Font.boldH3.value
        self.closeButton?.setTitleColor(.black, for: .normal)
        self.closeButton?.backgroundColor = .white
    }
    func updateForChromeCast(_ currentTime: Double,
                             totalTime: Double,
                             isPlaying: Bool) {
        guard let nextEpisodeDuration = self.nextEpisodeDuration, self.canShow else { self.isHidden = true; return }
        if isPlaying == true {
            if currentTime >= nextEpisodeDuration.0, !self.isAnimating, !self.isDismissed {
                self.isHidden = false
                self.startAnimation(elapsedTime: currentTime, totalDuration: totalTime)
            } else if self.isAnimationPaused {
                self.isAnimationPaused = false
                self.resumeAnimation()
            } else if let nextEpisodeDuration = self.nextEpisodeDuration, currentTime < nextEpisodeDuration.0 {
                self.isDismissed = false
                self.stopAnimation(false)
            }
        } else {
            guard !isAnimating else { return }
            self.isAnimationPaused = true
            self.pauseAnimation()
        }
    }
    public func resetValue() {
        self.isDismissed = false
        self.isAnimating = false
        self.isAnimationPaused = false
        self.nextEpisodeDuration = nil
        self.releaseLayerAnimation()
    }
    private func startAnimation(elapsedTime: Double, totalDuration: Double) {
        guard let nextEpisodeDuration = nextEpisodeDuration else { return }
        let playerElapseDuration = (nextEpisodeDuration.0 + nextEpisodeDuration.1) - elapsedTime
        let finishDuration = totalDuration - elapsedTime
        let duration = playerElapseDuration < 0 ? min(finishDuration, nextEpisodeDuration.1) : min(playerElapseDuration, nextEpisodeDuration.1)
        self.performAnimation(duration: duration)
        self.isAnimating = true
    }
}
