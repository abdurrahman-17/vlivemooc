//
//  Poster.swift
//
//  Created by Hiren on 17/10/19
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Poster: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case filelist
        case postertype
        case quality
        case posterid
        case pgrating
    }
    var title: String?
    var filelist: [Filelist]?
    var postertype: String?
    var quality: String?
    var posterid: String?
    var pgrating: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        filelist = try? container.decodeIfPresent([Filelist].self, forKey: .filelist)
        postertype = try? container.decodeIfPresent(String.self, forKey: .postertype)
        quality = try? container.decodeIfPresent(String.self, forKey: .quality)
        posterid = try? container.decodeIfPresent(String.self, forKey: .posterid)
        pgrating = try? container.decodeIfPresent(String.self, forKey: .pgrating)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(filelist, forKey: .filelist)
        try container.encode(postertype, forKey: .postertype)
        try container.encode(quality, forKey: .quality)
        try container.encode(posterid, forKey: .posterid)
        try container.encode(pgrating, forKey: .pgrating)
    }
}
