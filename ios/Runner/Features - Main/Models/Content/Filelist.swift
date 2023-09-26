//
//  Filelist.swift
//
//  Created by Sasikumar on 07/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class Filelist: Codable {
    enum CodingKeys: String, CodingKey {
        case quality
        case filename
    }
    var quality: String?
    var filename: String?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quality = try? container.decodeIfPresent(String.self, forKey: .quality)
        filename = try? container.decodeIfPresent(String.self, forKey: .filename)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(quality, forKey: .quality)
        try container.encode(filename, forKey: .filename)
    }
}
