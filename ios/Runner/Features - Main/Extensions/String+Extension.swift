//
//  String+Extensions.swift
//  MOBIPlayer-Noor-Clone
//
//  Created by Sasikumar D on 20/04/23.
//

import UIKit

extension String {
    public var localized: String {
        return LocalizationManager.shared.localizedStringForKey(key: self, comment: "")
    }
    func toInt() -> Int? {
        Int(self)
    }
}
