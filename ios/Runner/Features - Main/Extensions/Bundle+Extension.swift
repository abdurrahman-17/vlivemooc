//
//  Bundle+Extension.swift
//  VLIVE
//
//  Created by Sasikumar on 22/12/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//

import UIKit

private var kBundleKey: UInt8 = 0

class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &kBundleKey) as? Bundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}
extension Bundle {
    static let once: Void = {
        object_setClass(Bundle.main, type(of: BundleEx()))
    }()
    class func setLanguage(_ language: String?) {
        guard let language = language else { return }
        Bundle.once
        let isLanguageRTL = Bundle.isLanguageRTL(language)
        if (isLanguageRTL) {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let value = Bundle.init(path: Bundle.main.path(forResource: language, ofType: "lproj") ?? "")
        objc_setAssociatedObject(Bundle.main, &kBundleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    class func isLanguageRTL(_ languageCode: String? = UserDefaults.standard.object(forKey: "kLanguage") as? String) -> Bool {
        guard let language = languageCode else { return false}
        return Locale.characterDirection(forLanguage: language) == .rightToLeft
    }
}
