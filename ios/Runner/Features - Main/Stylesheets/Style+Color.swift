//
//  Style+Color.swift
//  SDG
//
//  Created by Sasikumar on 10/07/19.
//  Copyright © 2019 Mobiotics. All rights reserved.
//

import UIKit

enum Color: String {
    case background
    case navigationBarColor
    case navigationTitle
    case cardActive
    case cardInActive
    /// TextPrimary - Dark - #F7F9FC, Light - #1F2228
    case textPrimary
    case textSecondary
    case errorText
    case brandColor
    case shadowColor
    // Label
    case header1
    // Button
    case buttonText
    // Gradient
    case gradient1
    case gradient2
    // Textfield
    case textfieldBorder
    case errorBorder
    case successBorder
    case textFocus
    case textFieldUnFocus
    case textFieldPlaceHolder
    case textFieldText
    // Tags - Live, New, Free, Premium
    case tagBlue
    case tagRed
    case tagAdmin
    case ribbonColor
    // Progress Bar
    case progressBar
    // Detail Bottom
    case detailBottom
    // plan Ribbon
    case planRibbon
    // highlight green
    case hightLightGreen
    // Quality
    case quality
    // highlight red
    case highlightRed
    // blue color
    case blueColor
    // Notification Badge
    case badgeColor
    // price selected
    case priceSelected
    //playback Speed
    case playbackSpeed
    // planExpire
    case planExpire
    //shield color
    case shieldColor
    // tabbar Normal color
    case tabbarNormal
    // tabbar Selected color
    case tabbarSelected
    // category normal
    case categoryNormal
    // category selected
    case tabBarColor
    case categorySelected
    case menuBackground
    case searchPlaceHolder
    // highlight white
    case highLightWhite
    // black gradient background
    case backgroundBlackGradient1
    case backgroundBlackGradient2
    // red gradient background
    case backgroundGrayGradient1
    case backgroundGrayGradient2
    case viewBackgroundGray
    case planTermText
}
extension Color {
    var value: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .background:
            instanceColor = UIColor(hexString: "#0e0f10")
        case .navigationBarColor:
            instanceColor = UIColor(hexString: "#0f0f0f")
        case .cardActive:
            instanceColor = UIColor(hexString: "#212121")
        case .cardInActive:
            instanceColor = UIColor(hexString: "#0D0D0D")
        case .textPrimary:
            instanceColor = UIColor(hexString: "#F7F9FC")
        case .textSecondary:
            instanceColor = UIColor(hexString: "#70787F")
        case .gradient1:
            instanceColor = UIColor(hexString: "#380510")
        case .gradient2:
            instanceColor = UIColor(hexString: "#8B1836")
        case .textfieldBorder:
            instanceColor = UIColor(hexString: "#32363E")
        case .errorText:
            instanceColor = UIColor(hexString: "#ED262A")
        case .brandColor:
            instanceColor = UIColor(hexString: "#8B1836")
        case .textFocus:
            instanceColor = UIColor(hexString: "#000000")
        case .textFieldUnFocus:
            instanceColor = UIColor(hexString: "#0A0A0A")
        case .shadowColor:
            instanceColor = UIColor.black
        case .ribbonColor:
            instanceColor = UIColor(hexString: "#ED2658")
        case .errorBorder:
            instanceColor = UIColor(hexString: "#B93938")
        case .successBorder:
            instanceColor = UIColor(hexString: "#1F592D")
        case .tagBlue:
            instanceColor = UIColor(hexString: "#8B1836")
        case .tagRed:
            instanceColor = UIColor(hexString: "#FF7C8E")
        case .textFieldPlaceHolder:
            instanceColor = UIColor(hexString: "#5C6168")
        case .textFieldText:
            instanceColor = UIColor(hexString: "#B8C0C7")
        case .header1:
            instanceColor = UIColor(hexString: "#B8C0C7")
        case .buttonText:
            instanceColor = UIColor(hexString: "#F7F9FC")
        case .progressBar:
            instanceColor = UIColor(hexString: "#FF2222")
        case .detailBottom:
            instanceColor = UIColor(hexString: "#0A0A0A")
        case .planRibbon:
            instanceColor = UIColor(hexString: "#8B1836")
        case .hightLightGreen:
            instanceColor = UIColor(hexString: "#29D65B")
        case .quality:
            instanceColor = UIColor(hexString: "#FF9600")
        case .highlightRed:
            instanceColor = UIColor(hexString: "#FF6363")
        case .blueColor:
            instanceColor = UIColor(hexString: "#4D7BFF")
        case .tagAdmin:
            instanceColor = .white
        case .badgeColor:
            instanceColor = UIColor(hexString: "#E84848")
        case .priceSelected:
            instanceColor = UIColor(hexString: "#121416")
        case .navigationTitle:
            instanceColor = UIColor(hexString: "#F7F9FC")
        case .playbackSpeed:
            instanceColor = UIColor(hexString: "#E75540")
        case .planExpire:
            instanceColor = UIColor(hexString: "#FF4165")
        case .shieldColor:
            instanceColor = UIColor(hexString: "#4665D0")
        case .tabbarNormal:
            instanceColor = UIColor(hexString: "#F7F9FC")
        case .tabbarSelected:
            instanceColor = UIColor(hexString: "#8B1836")
        case .categoryNormal:
            instanceColor = UIColor(hexString: "#F7F9FC")
        case .categorySelected:
            instanceColor = UIColor(hexString: "#E81C25")
        case .tabBarColor:
            instanceColor = UIColor(hexString: "#000000")
        case .menuBackground:
            instanceColor = UIColor(hexString: "#000000")
        case .searchPlaceHolder:
            instanceColor = UIColor(hexString: "#5C6168")
        case .highLightWhite:
            instanceColor = UIColor(hexString: "#000000")
        case .backgroundBlackGradient1:
            instanceColor = UIColor(hexString: "#000000").withAlphaComponent(0.7)
        case .backgroundBlackGradient2:
            instanceColor = UIColor(hexString: "#FFFFFF")
        case .backgroundGrayGradient1:
            instanceColor = UIColor(hexString: "#3F3F3F")
        case .backgroundGrayGradient2:
            instanceColor = UIColor(hexString: "#0E0E0E")
        case .viewBackgroundGray:
            instanceColor = UIColor(hexString: "#2C2C2E").withAlphaComponent(0.3)
        case .planTermText:
            instanceColor = UIColor(hexString: "#FFFFFF")
        }
        return instanceColor
    }
    var overlayValue: UIColor {
        var instanceColor = UIColor.clear
        if self == .textSecondary {
            instanceColor = UIColor(hexString: "#70787F")
        } else if self == .textPrimary {
            instanceColor = UIColor(hexString: "#F7F9FC")
        } else if self == .textfieldBorder {
            instanceColor = UIColor(hexString: "#202A32")
        }
        return instanceColor
    }
}
