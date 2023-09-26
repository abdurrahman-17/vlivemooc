//
//  Constants.swift
//  MOBIPlayer-Noor-Clone
//
//  Created by Sasikumar D on 20/04/23.
//

import UIKit

class Constant: NSObject {
    static let isIpad = UIDevice.current.userInterfaceIdiom == .pad
}
var appDelegateObj: AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
}
struct HardCodedText {
    static let live = "Live"
    static let skipCredits = "SKIP INTRO"
    static let normal = "Normal"
    static let playbackSpeed = "PLAYBACK SPEED"
    static let off = "Off"
    static let auto = "Auto"
    static let quality = "QUALITY"
    static let audio = "AUDIO"
    static let subtitles = "SUBTITLES"
    static let goLive = "GO LIVE"
}
enum DRMType: String {
    case widevine
    case fairplay
    case clear
}
public enum DisplayType: String {
    case LANDSCAPE
    case PORTRAIT
    case SQUARE
    case MIXED
}
