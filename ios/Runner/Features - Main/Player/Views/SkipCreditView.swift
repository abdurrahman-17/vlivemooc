//
//  SkipCreditView.swift
//  VLIVE
//
//  Created by Sasikumar on 22/01/21.
//  Copyright © 2021 Mobiotics. All rights reserved.
//

import UIKit
#if MOBIRELEASE
import MOBIPlayerRelease
#endif
#if MOBIDEBUG
import MOBIPlayer
#endif
class SkipCreditView: MOBISkipCreditView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.closeButton?.roundCorners(radius: self.bounds.height / 2)
    }
    override func addSkipCreditButton() {
        super.addSkipCreditButton()
        self.skipCreditButton?.setTitle((HardCodedText.skipCredits.localized).capitalized, for: .normal)
        self.skipCreditButton?.titleLabel?.font = Font.boldH3.value
        self.skipCreditButton?.setTitleColor(.black, for: .normal)
        self.skipCreditButton?.backgroundColor = .white
        self.skipCreditButton?.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.skipCreditButton?.roundCorners(radius: 4)
        self.closeButton?.titleLabel?.font = Font.boldH3.value
        self.closeButton?.setTitleColor(.black, for: .normal)
        self.closeButton?.backgroundColor = .white
        self.closeButton?.isHidden = true
    }
    public func resetValue() {
        self.isDismissed = false
        self.skipCreditDuration = nil
    }
    func updateSkipCreditForChromeCast(_ currentTime: Double,
                                       totalTime: Double,
                                       isPlaying: Bool) {
        self.isHidden = true
        if isPlaying == true {
            guard let skipCreditDuration = self.skipCreditDuration else {
                return
            }
            if currentTime >= skipCreditDuration.0, currentTime <= skipCreditDuration.1, self.isButtonPressed == false, self.isDismissed == false {
                self.isHidden = false
            } else {
                self.isHidden = true
                if currentTime > skipCreditDuration.1 || currentTime < skipCreditDuration.0 {
                    self.isButtonPressed = false
                    self.isDismissed = false
                }
            }
        }
    }
}
