//
//  Cast.swift
//
//  Created by Sasikumar on 08/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class Cast: Codable {
    enum CodingKeys: String, CodingKey {
        case role
        case cast
    }
    var role: String?
    var cast: String?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        role = try? container.decodeIfPresent(String.self, forKey: .role)
        cast = try? container.decodeIfPresent(String.self, forKey: .cast)
    }
}
