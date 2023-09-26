//
//  StreamDetails.swift
//
//  Created by Sasikumar on 07/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class StreamDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case packageid
        case streamtype
        case streamfilename
        case packagedfilelist
        case drmscheme
        case streammode
        case quality
        // Loacl
        case contentId
        case availability
        case mediaId
    }
    var packageid: String?
    var streamtype: String?
    var streamfilename: String?
    var packagedList: PackagedList?
    var drmscheme: [String]?
    var streammode: String?
    var quality: String?
    var contentId: String? // Local
    var availability: Availability? // Local
    var mediaId: String? // Local
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        packageid = try? container.decodeIfPresent(String.self, forKey: .packageid)
        streamtype = try? container.decodeIfPresent(String.self, forKey: .streamtype)
        streamfilename = try? container.decodeIfPresent(String.self, forKey: .streamfilename)
        packagedList = try? container.decodeIfPresent(PackagedList.self, forKey: .packagedfilelist)
        drmscheme = try? container.decodeIfPresent([String].self, forKey: .drmscheme)
        streammode = try? container.decodeIfPresent(String.self, forKey: .streammode)
        quality = try? container.decodeIfPresent(String.self, forKey: .quality)
        contentId = try? container.decodeIfPresent(String.self, forKey: .contentId)
        mediaId = try? container.decodeIfPresent(String.self, forKey: .mediaId)
        availability = try? container.decodeIfPresent(Availability.self, forKey: .availability)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(quality, forKey: .quality)
        try container.encode(packageid, forKey: .packageid)
        try container.encode(streamtype, forKey: .streamtype)
        try container.encode(streamfilename, forKey: .streamfilename)
        try container.encode(packagedList, forKey: .packagedfilelist)
        try container.encode(drmscheme, forKey: .drmscheme)
        try container.encode(streammode, forKey: .streammode)
        try container.encode(contentId, forKey: .contentId)
        try container.encode(availability, forKey: .availability)
        try container.encode(mediaId, forKey: .mediaId)
    }
    public func toJson() -> String? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    var drmType: DRMType {
        if drmscheme?.contains("WIDEVINE") == true {
            return .widevine
        } else if drmscheme?.contains("FAIRPLAY") == true {
            return .fairplay
        } else {
            return .clear
        }
    }
}
