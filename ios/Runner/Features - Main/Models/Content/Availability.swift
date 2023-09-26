//
//  Availability.swift
//
//  Created by Sasikumar on 08/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class Availability: Codable {
    enum CodingKeys: String, CodingKey {
        case quality
        case availabilityid
        case availabilityname
        case regionlist
        case descriptionValue = "description"
        case exclusionlist
        case pricemodel
        case devicetypelist
        case licenseduration
        case accesstype
        case adcueid
        case country
        case adcuedetails
        case priceclassdetail
    }
    var quality: String?
    var availabilityid: String?
    var availabilityname: String?
    var regionlist: [String]?
    var descriptionValue: String?
    var exclusionlist: [String]?
    var pricemodel: String?
    var devicetypelist: [String]?
    var licenseduration: Int?
    var accesstype: String?
    var adcueid: String?
    var country: [String]?
    var adcuedetails: AdcueDetails?
    var priceclassdetail: [PriceClass]?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quality = try? container.decodeIfPresent(String.self, forKey: .quality)
        availabilityid = try? container.decodeIfPresent(String.self, forKey: .availabilityid)
        availabilityname = try? container.decodeIfPresent(String.self, forKey: .availabilityname)
        regionlist = try? container.decodeIfPresent([String].self, forKey: .regionlist)
        descriptionValue = try? container.decodeIfPresent(String.self, forKey: .descriptionValue)
        exclusionlist = try? container.decodeIfPresent([String].self, forKey: .exclusionlist)
        pricemodel = try? container.decodeIfPresent(String.self, forKey: .pricemodel)
        devicetypelist = try? container.decodeIfPresent([String].self, forKey: .devicetypelist)
        licenseduration = try? container.decodeIfPresent(Int.self, forKey: .licenseduration)
        accesstype = try? container.decodeIfPresent(String.self, forKey: .accesstype)
        adcueid = try? container.decodeIfPresent(String.self, forKey: .adcueid)
        country = try? container.decodeIfPresent([String].self, forKey: .country)
        adcuedetails = try? container.decodeIfPresent(AdcueDetails.self, forKey: .adcuedetails)
        priceclassdetail = try? container.decodeIfPresent([PriceClass].self, forKey: .priceclassdetail)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(quality, forKey: .quality)
        try container.encode(availabilityid, forKey: .availabilityid)
        try container.encode(availabilityname, forKey: .availabilityname)
        try container.encode(regionlist, forKey: .regionlist)
        try container.encode(descriptionValue, forKey: .descriptionValue)
        try container.encode(exclusionlist, forKey: .exclusionlist)
        try container.encode(pricemodel, forKey: .pricemodel)
        try container.encode(devicetypelist, forKey: .devicetypelist)
        try container.encode(licenseduration, forKey: .licenseduration)
        try container.encode(accesstype, forKey: .accesstype)
        try container.encode(adcueid, forKey: .adcueid)
        try container.encode(country, forKey: .country)
        try container.encode(adcuedetails, forKey: .adcuedetails)
        try container.encode(priceclassdetail, forKey: .priceclassdetail)
    }
}
