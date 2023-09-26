//
//  SkipSettings.swift
//  VLIVE
//
//  Created by Sasikumar on 29/06/21.
//  Copyright © 2021 Mobiotics. All rights reserved.
//

import UIKit

class SkipSettings: Codable {
    enum CodingKeys: String, CodingKey {
        case start
        case end
        case skiptype
        case userType
    }
    let start: Double?
    let end: Double?
    let skiptype: String?
    let userType: String?
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        start = try? values.decodeIfPresent(Double.self, forKey: .start)
        end = try? values.decodeIfPresent(Double.self, forKey: .end)
        skiptype = try? values.decodeIfPresent(String.self, forKey: .skiptype)
        userType = try? values.decodeIfPresent(String.self, forKey: .userType)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(start, forKey: .start)
        try container.encode(end, forKey: .end)
        try container.encode(skiptype, forKey: .skiptype)
        try container.encode(userType, forKey: .userType)
    }
}
