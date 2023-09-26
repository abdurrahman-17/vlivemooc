//
//  LocalizationManager.swift
//  VLIVE
//
//  Created by Vikesh on 21/12/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//

import Foundation
class LocalizationManager:NSObject {
    public static let shared = LocalizationManager()
    override private init() {
        super.init()
    }
    func localizedStringForKey(key:String, comment:String) -> String {
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        if let languageDirectoryPath = Bundle.main.path(forResource: appleLanguages?.first ?? "en", ofType: "lproj") {
            return Bundle.init(path: languageDirectoryPath)?.localizedString(forKey: key, value: comment, table: nil) ?? ""
        } else {
            return Bundle.main.localizedString(forKey: key, value: comment, table: nil)
        }
    }
    // MARK: - setLanguage
    func setLanguage(languageCode:String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        Bundle.setLanguage(languageCode)
    }
}
