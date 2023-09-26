//
//  PriceClass.swift
//  VLIVE
//
//  Created by Sasikumar on 27/11/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//

import Foundation

class PriceClass: Codable {
    enum CodingKeys: String, CodingKey {
        case currency
        case price
        case priceclassid
        case priceclassname
        case priceclasstype
    }
    let currency : String?
    let price : Int?
    let priceclassid: String?
    let priceclassname: String?
    let priceclasstype: String?
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency = try? values.decodeIfPresent(String.self, forKey: .currency)
        price = try? values.decodeIfPresent(Int.self, forKey: .price)
        priceclassid = try? values.decodeIfPresent(String.self, forKey: .priceclassid)
        priceclassname = try? values.decodeIfPresent(String.self, forKey: .priceclassname)
        priceclasstype = try? values.decodeIfPresent(String.self, forKey: .priceclasstype)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currency, forKey: .currency)
        try container.encode(price, forKey: .price)
        try container.encode(priceclassid, forKey: .priceclassid)
        try container.encode(priceclassname, forKey: .priceclassname)
        try container.encode(priceclasstype, forKey: .priceclasstype)
    }
}
