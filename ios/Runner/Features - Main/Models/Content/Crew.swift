//
//  Crew.swift
//
//  Created by Sasikumar on 08/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class Crew: Codable {
    enum CodingKeys: String, CodingKey {
        case crew
        case role
    }
    var crew: String?
    var role: String?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        crew = try? container.decodeIfPresent(String.self, forKey: .crew)
        role = try? container.decodeIfPresent(String.self, forKey: .role)
    }
}
