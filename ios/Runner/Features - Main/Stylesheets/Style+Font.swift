//
//  Style+Font.swift
//  SDG
//
//  Created by Sasikumar on 10/07/19.
//  Copyright © 2019 Mobiotics. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    case h1Size = 24.0 // Title
    case h2Size = 20.0 // Sub
    case h3Size = 16.0 // Body
    case h4Size = 14.0 // Secondary
    case h5Size = 12.0 // Micro
    case h6Size = 10.0 // Micro
    case tag = 8
    case aprich1Size = 35.0
}
enum FontIpadSize: CGFloat {
    case h1Size = 26.0 // Title
    case h2Size = 22.0 // Sub
    case h3Size = 18.0 // Body
    case h4Size = 16.0 // Secondary
    case h5Size = 14.0 // Micro
    case h6Size = 12.0 // Micro
    case tag = 10
    case aprich1Size = 35.0
}
enum FontName: String {
    case regular = "DroidArabicKufi"
    case bold = "DroidArabicKufi-Bold"
    case semiBold = "HelveticaNeue-Medium"
    case apricBRegular = "ApricBBlack"
    case black = "HelveticaNeue-CondensedBold"
    case italic = "HelveticaNeue-Italic"
    var value: String {
        if Bundle.isLanguageRTL() {
            switch self {
            case .regular:
                return "DroidArabicKufi"
            case .bold:
                return "DroidArabicKufi-Bold"
            case .semiBold:
                return "DroidArabicKufi"
            case .apricBRegular:
                return "ApricBBlack"
            case .black:
                return "DroidArabicKufi-Bold"
            case .italic:
                return "HelveticaNeue-Italic"
            }
        } else {
            switch self {
            case .regular:
                return "HelveticaNeue"
            case .bold:
                return "HelveticaNeue-Bold"
            case .semiBold:
                return "HelveticaNeue-Medium"
            case .apricBRegular:
                return "ApricBBlack"
            case .black:
                return "HelveticaNeue-CondensedBold"
            case .italic:
                return "HelveticaNeue-Italic"
            }
        }
    }
}
enum Font {
    // BOLD
    case boldH1
    case boldH2
    case boldH3
    case boldH4
    case boldH5
    case boldH6
    case boldTag
    // REGULAR
    case regularH1
    case regularH2
    case regularH3
    case regularH4
    case regularH5
    case regularH6
    // SEMI BOLD
    case semiBoldH1
    case semiBoldH2
    case semiBoldH3
    case semiBoldH4
    case semiBoldH5
    case semiBoldH6
    case semiBoldTag
    //Apric b Regular
    case apricRegularH1
    case apricRegularH2
}
extension Font {
    var value: UIFont {
        var instanceFont: UIFont!
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        switch self {
        case .boldH1:
            instanceFont = UIFont(name: FontName.bold.value,
                                  size: isIpad ? FontIpadSize.h1Size.rawValue : FontSize.h1Size.rawValue)
        case .boldH2:
            instanceFont = UIFont(name: FontName.bold.value,
                                  size: isIpad ? FontIpadSize.h2Size.rawValue : FontSize.h2Size.rawValue)
        case .boldH3:
            instanceFont = UIFont(name: FontName.bold.value,
                                  size: isIpad ? FontIpadSize.h3Size.rawValue : FontSize.h3Size.rawValue)
        case .boldH4:
            instanceFont = UIFont(name: FontName.bold.value,
                                  size: isIpad ? FontIpadSize.h4Size.rawValue : FontSize.h4Size.rawValue)
        case .boldH5:
            instanceFont = UIFont(name: FontName.bold.value,
                                  size: isIpad ? FontIpadSize.h5Size.rawValue : FontSize.h5Size.rawValue)
        case .boldH6:
            instanceFont = UIFont(name: FontName.bold.value,
                                  size: isIpad ? FontIpadSize.h6Size.rawValue : FontSize.h6Size.rawValue)
        case .boldTag:
            instanceFont = UIFont(name: FontName.bold.value,
                                  size: isIpad ? FontIpadSize.tag.rawValue : FontSize.tag.rawValue)
        case .regularH1:
            instanceFont = UIFont(name: FontName.regular.value,
                                  size: isIpad ? FontIpadSize.h1Size.rawValue : FontSize.h1Size.rawValue)
        case .regularH2:
            instanceFont = UIFont(name: FontName.regular.value,
                                  size: isIpad ? FontIpadSize.h2Size.rawValue : FontSize.h2Size.rawValue)
        case .regularH3:
            instanceFont = UIFont(name: FontName.regular.value,
                                  size: isIpad ? FontIpadSize.h3Size.rawValue : FontSize.h3Size.rawValue)
        case .regularH4:
            instanceFont = UIFont(name: FontName.regular.value,
                                  size: isIpad ? FontIpadSize.h4Size.rawValue : FontSize.h4Size.rawValue)
        case .regularH5:
            instanceFont = UIFont(name: FontName.regular.value,
                                  size: isIpad ? FontIpadSize.h5Size.rawValue : FontSize.h5Size.rawValue)
        case .regularH6:
            instanceFont = UIFont(name: FontName.regular.value,
                                  size: isIpad ? FontIpadSize.h6Size.rawValue : FontSize.h6Size.rawValue)
        case .semiBoldH1:
            instanceFont = UIFont(name: FontName.semiBold.value,
                                  size: isIpad ? FontIpadSize.h1Size.rawValue : FontSize.h1Size.rawValue)
        case .semiBoldH2:
            instanceFont = UIFont(name: FontName.semiBold.value,
                                  size: isIpad ? FontIpadSize.h2Size.rawValue : FontSize.h2Size.rawValue)
        case .semiBoldH3:
            instanceFont = UIFont(name: FontName.semiBold.value,
                                  size: isIpad ? FontIpadSize.h3Size.rawValue : FontSize.h3Size.rawValue)
        case .semiBoldH4:
            instanceFont = UIFont(name: FontName.semiBold.value,
                                  size: isIpad ? FontIpadSize.h4Size.rawValue : FontSize.h4Size.rawValue)
        case .semiBoldH5:
            instanceFont = UIFont(name: FontName.semiBold.value,
                                  size: isIpad ? FontIpadSize.h5Size.rawValue : FontSize.h5Size.rawValue)
        case .semiBoldH6:
            instanceFont = UIFont(name: FontName.semiBold.value,
                                  size: isIpad ? FontIpadSize.h6Size.rawValue : FontSize.h6Size.rawValue)
        case .semiBoldTag:
            instanceFont = UIFont(name: FontName.semiBold.value,
                                  size: isIpad ? FontIpadSize.tag.rawValue : FontSize.tag.rawValue)
        case .apricRegularH1:
            instanceFont = UIFont(name: FontName.apricBRegular.value,
                                  size: isIpad ? FontIpadSize.aprich1Size.rawValue : FontSize.aprich1Size.rawValue)
        case .apricRegularH2:
            instanceFont = UIFont(name: FontName.apricBRegular.value,
                                  size: isIpad ? FontIpadSize.h1Size.rawValue : FontSize.h1Size.rawValue)
        }
        return instanceFont
    }
}
