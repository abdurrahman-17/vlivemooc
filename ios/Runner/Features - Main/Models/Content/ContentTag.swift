//
//  ContentTag.swift
//  VLIVE
//
//  Created by Sasikumar on 31/07/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//

import UIKit
enum ContentTagType {
    case category
    case genre
    case language
    case year
    case normal
    case subgenre
    case loadMore
    case artist
    case customContentType
}
struct ContentTag {
    var name: String?
    var type: ContentTagType! = .normal
    var content: Any?
    var tag: String?
}
