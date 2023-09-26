//
//  Scrubbing.swift
//  VLIVE
//
//  Created by Debashish Das on 10/09/22.
//  Copyright © 2022 Mobiotics. All rights reserved.
//

import Foundation

class Scrubbing: Codable {
    enum CodingKeys: String, CodingKey {
        case column
        case filename
        case height
        case interval
        case row
        case seekThumbnailImagePath
        case total
        case width
    }
    var column: String?
    var fileName: String?
    var height: String?
    var interval: String?
    var row: String?
    var seekThumbnailImagePath: String?
    var total: String?
    var width: String?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        column = try? container.decodeIfPresent(String.self, forKey: .column)
        fileName = try? container.decodeIfPresent(String.self, forKey: .filename)
        height = try? container.decodeIfPresent(String.self, forKey: .height)
        interval = try? container.decodeIfPresent(String.self, forKey: .interval)
        row = try? container.decodeIfPresent(String.self, forKey: .row)
        seekThumbnailImagePath = try? container.decodeIfPresent(String.self, forKey: .seekThumbnailImagePath)
        total = try? container.decodeIfPresent(String.self, forKey: .total)
        width = try? container.decodeIfPresent(String.self, forKey: .width)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(column, forKey: .column)
        try container.encode(fileName, forKey: .filename)
        try container.encode(height, forKey: .height)
        try container.encode(interval, forKey: .interval)
        try container.encode(row, forKey: .row)
        try container.encode(seekThumbnailImagePath, forKey: .seekThumbnailImagePath)
        try container.encode(total, forKey: .total)
        try container.encode(width, forKey: .width)
    }
}
