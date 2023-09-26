//
//  Contentdetails.swift
//
//  Created by Sasikumar on 07/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class Contentdetails: Codable {
    enum CodingKeys: String, CodingKey {
        case drmscheme
        case jobid
        case streamtype
        case availabilityset
        case streammode
        case quality
        case mediaid
        case packageid
        case levelid
        case leveltitle
        case leveltype
        case audiolang
        case subtitlelang
        case streamfilename
        case clearlead
    }
    var drmscheme: [String]?
    var jobid: String?
    var streamtype: String?
    var availabilityset: [String]?
    var streammode: String?
    var quality: String?
    var mediaid: String?
    var packageid: String?
    var availabilities: [Availability]?
    var levelid: String?
    var leveltitle: String?
    var leveltype: String?
    var audiolang: [String]?
    var subtitlelang: [String]?
    var streamfilename: String?
    var clearlead: Int?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        drmscheme = try? container.decodeIfPresent([String].self, forKey: .drmscheme)
        jobid = try? container.decodeIfPresent(String.self, forKey: .jobid)
        streamtype = try? container.decodeIfPresent(String.self, forKey: .streamtype)
        availabilityset = try? container.decodeIfPresent([String].self, forKey: .availabilityset)
        streammode = try? container.decodeIfPresent(String.self, forKey: .streammode)
        quality = try? container.decodeIfPresent(String.self, forKey: .quality)
        mediaid = try? container.decodeIfPresent(String.self, forKey: .mediaid)
        packageid = try? container.decodeIfPresent(String.self, forKey: .packageid)
        levelid = try? container.decodeIfPresent(String.self, forKey: .levelid)
        leveltitle = try? container.decodeIfPresent(String.self, forKey: .leveltitle)
        leveltype = try? container.decodeIfPresent(String.self, forKey: .leveltype)
        audiolang = try? container.decodeIfPresent([String].self, forKey: .audiolang)
        subtitlelang = try? container.decodeIfPresent([String].self, forKey: .subtitlelang)
        streamfilename = try? container.decodeIfPresent(String.self, forKey: .streamfilename)
        clearlead = try? container.decodeIfPresent(Int.self, forKey: .clearlead)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(drmscheme, forKey: .drmscheme)
        try container.encode(jobid, forKey: .jobid)
        try container.encode(streamtype, forKey: .streamtype)
        try container.encode(availabilityset, forKey: .availabilityset)
        try container.encode(streammode, forKey: .streammode)
        try container.encode(quality, forKey: .quality)
        try container.encode(mediaid, forKey: .mediaid)
        try container.encode(packageid, forKey: .packageid)
        try container.encode(levelid, forKey: .levelid)
        try container.encode(leveltitle, forKey: .leveltitle)
        try container.encode(leveltype, forKey: .leveltype)
        try container.encode(audiolang, forKey: .audiolang)
        try container.encode(subtitlelang, forKey: .subtitlelang)
        try container.encode(streamfilename, forKey: .streamfilename)
        try container.encode(clearlead, forKey: .clearlead)
    }
    var subtitleLanguages: [String]? {
        var languages = [String]()
        subtitlelang?.forEach({ languageCode in
            if let language = NSLocale(localeIdentifier: languageCode).displayName(forKey: NSLocale.Key.identifier, value: languageCode) {
                languages.append(language)
            }
        })
        return languages
    }
    var audioLanguages: [String]? {
        var languages = [String]()
        audiolang?.forEach({ languageCode in
            if let language = NSLocale(localeIdentifier: languageCode).displayName(forKey: NSLocale.Key.identifier, value: languageCode) {
                languages.append(language)
            }
        })
        return languages
    }
}
