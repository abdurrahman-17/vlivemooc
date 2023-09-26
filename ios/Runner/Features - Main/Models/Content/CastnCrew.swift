//
//  CastnCrew.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 30, 2022
//
import Foundation

struct CastnCrew: Codable {
    let castncrewid: String?
    let name: String?
    let profilepic: String?
    let description: String?
    let birthyear: Int?
    let gender: String?
    let imdbid: Any?
    let nationality: String?
    let role: [String]?
    let awards: String?
    let created: String?
    private enum CodingKeys: String, CodingKey {
        case castncrewid
        case name
        case profilepic
        case description
        case birthyear
        case gender
        case imdbid
        case nationality
        case role
        case awards
        case created
    }
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        castncrewid = try? values?.decode(String.self, forKey: .castncrewid)
        name = try? values?.decode(String.self, forKey: .name)
        profilepic = try? values?.decode(String.self, forKey: .profilepic)
        description = try? values?.decode(String.self, forKey: .description)
        birthyear = try? values?.decode(Int.self, forKey: .birthyear)
        gender = try? values?.decode(String.self, forKey: .gender)
        imdbid = nil
        nationality = try? values?.decode(String.self, forKey: .nationality)
        role = try? values?.decode([String].self, forKey: .role)
        awards = try? values?.decode(String.self, forKey: .awards)
        created = try? values?.decode(String.self, forKey: .created)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(castncrewid, forKey: .castncrewid)
        try container.encode(name, forKey: .name)
        try container.encode(profilepic, forKey: .profilepic)
        try container.encode(description, forKey: .description)
        try container.encode(birthyear, forKey: .birthyear)
        try container.encode(gender, forKey: .gender)
        try container.encode(nationality, forKey: .nationality)
        try container.encode(role, forKey: .role)
        try container.encode(awards, forKey: .awards)
        try container.encode(created, forKey: .created)
    }
}
