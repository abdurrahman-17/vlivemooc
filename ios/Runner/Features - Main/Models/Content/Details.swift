//
//  Details.swift
//
//  Created by Sasikumar on 08/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class Details: Codable {
    enum CodingKeys: String, CodingKey {
        case crew
        case cast
        case deeplink
        case buttontext
    }
    var crew: [Crew]?
    var cast: [Cast]?
    var deeplink: String?
    var buttontext: [String: String?]?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        crew = try? container.decodeIfPresent([Crew].self, forKey: .crew)
        cast = try? container.decodeIfPresent([Cast].self, forKey: .cast)
        deeplink = try? container.decodeIfPresent(String.self, forKey: .deeplink)
        buttontext = try? container.decodeIfPresent([String: String?].self, forKey: .buttontext)
    }
}
