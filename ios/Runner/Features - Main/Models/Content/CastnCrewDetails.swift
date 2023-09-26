//
//  CastnCrewDetails.swift
//  VLIVE
//
//  Created by Sasikumar D on 01/02/23.
//  Copyright © 2023 Mobiotics. All rights reserved.
//

import UIKit

class CastnCrewDetails: Codable {
    let cast: [CastnCrew]?
    let crew: [CastnCrew]?
    private enum CodingKeys: String, CodingKey {
        case cast
        case crew
    }
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        cast = try? values?.decode([CastnCrew].self, forKey: .cast)
        crew = try? values?.decode([CastnCrew].self, forKey: .crew)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cast, forKey: .cast)
        try container.encode(crew, forKey: .crew)
    }
}
