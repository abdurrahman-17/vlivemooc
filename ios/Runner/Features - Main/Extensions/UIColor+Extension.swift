//
//  UIColor+Extension.swift
//  SDG
//
//  Created by Sasikumar on 10/07/19.
//  Copyright © 2019 Mobiotics. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let rColor = Int(color >> 16) & mask
        let gColor = Int(color >> 8) & mask
        let bColor = Int(color) & mask
        let redColor   = CGFloat(rColor) / 255.0
        let green = CGFloat(gColor) / 255.0
        let blue  = CGFloat(bColor) / 255.0
        self.init(red: redColor, green: green, blue: blue, alpha: 1)
    }
}
