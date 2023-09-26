//
//  Audio.swift
//
//  Created by Sasikumar on 07/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class Media: Codable {
    enum CodingKeys: String, CodingKey {
        case language
        case size
        case filename
        case quality
        case duration
    }
    var language: String?
    var size: String?
    var filename: String?
    var quality: String?
    var duration: String?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        language = try? container.decodeIfPresent(String.self, forKey: .language)
        size = try? container.decodeIfPresent(String.self, forKey: .size)
        filename = try? container.decodeIfPresent(String.self, forKey: .filename)
        quality = try? container.decodeIfPresent(String.self, forKey: .quality)
        duration = try? container.decodeIfPresent(String.self, forKey: .duration)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(language, forKey: .language)
        try container.encode(size, forKey: .size)
        try container.encode(filename, forKey: .filename)
        try container.encode(quality, forKey: .quality)
        try container.encode(duration, forKey: .duration)
    }
}
