import Foundation

class AdcueDetails : Codable {
    let adcueid : Int?
    let adcuename : String?
    let adinterval : Int?
    let adoffset : Int?
    let adoffsettype : String?
    let adposition : String?
    let creativetype : String?
    let maxadduration : Int?
    let mode : String?
    let skippable : String?
    let slotid : Int?
    let wrapperallowed : String?
    public var numads: Int? // not from api response
    enum CodingKeys: String, CodingKey {
        case adcueid
        case adcuename
        case adinterval
        case adoffset
        case adoffsettype
        case adposition
        case creativetype
        case maxadduration
        case mode
        case skippable
        case slotid
        case wrapperallowed
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adcueid = try? values.decodeIfPresent(Int.self, forKey: .adcueid)
        adcuename = try? values.decodeIfPresent(String.self, forKey: .adcuename)
        adinterval = try? values.decodeIfPresent(Int.self, forKey: .adinterval)
        adoffset = try? values.decodeIfPresent(Int.self, forKey: .adoffset)
        adoffsettype = try? values.decodeIfPresent(String.self, forKey: .adoffsettype)
        adposition = try? values.decodeIfPresent(String.self, forKey: .adposition)
        creativetype = try? values.decodeIfPresent(String.self, forKey: .creativetype)
        maxadduration = try? values.decodeIfPresent(Int.self, forKey: .maxadduration)
        mode = try? values.decodeIfPresent(String.self, forKey: .mode)
        skippable = try? values.decodeIfPresent(String.self, forKey: .skippable)
        slotid = try? values.decodeIfPresent(Int.self, forKey: .slotid)
        wrapperallowed = try? values.decodeIfPresent(String.self, forKey: .wrapperallowed)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adcueid, forKey: .adcueid)
        try container.encode(adcuename, forKey: .adcuename)
        try container.encode(adinterval, forKey: .adinterval)
        try container.encode(adoffset, forKey: .adoffset)
        try container.encode(adoffsettype, forKey: .adoffsettype)
        try container.encode(adposition, forKey: .adposition)
        try container.encode(creativetype, forKey: .creativetype)
        try container.encode(maxadduration, forKey: .maxadduration)
        try container.encode(mode, forKey: .mode)
        try container.encode(skippable, forKey: .skippable)
        try container.encode(slotid, forKey: .slotid)
        try container.encode(wrapperallowed, forKey: .wrapperallowed)
    }
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = adcueid { dictionary[CodingKeys.adcueid.rawValue] = value }
        if let value = adcuename { dictionary[CodingKeys.adcuename.rawValue] = value }
        if let value = adinterval { dictionary[CodingKeys.adinterval.rawValue] = value }
        if let value = adoffset { dictionary[CodingKeys.adoffset.rawValue] = value }
        if let value = adoffsettype { dictionary[CodingKeys.adoffsettype.rawValue] = value }
        if let value = adposition { dictionary[CodingKeys.adposition.rawValue] = value }
        if let value = creativetype { dictionary[CodingKeys.creativetype.rawValue] = value }
        if let value = maxadduration { dictionary[CodingKeys.maxadduration.rawValue] = value }
        if let value = mode { dictionary[CodingKeys.mode.rawValue] = value }
        if let value = skippable { dictionary[CodingKeys.skippable.rawValue] = value }
        if let value = slotid { dictionary[CodingKeys.slotid.rawValue] = value }
        if let value = wrapperallowed { dictionary[CodingKeys.wrapperallowed.rawValue] = value }
        if let value = numads { dictionary["numads"] = value }
        return dictionary
    }
}
