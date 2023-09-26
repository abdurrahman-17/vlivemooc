//
//  PlayContent.swift
//  MOBIPlayer-Noor-Clone
//
//  Created by Sasikumar D on 13/06/23.
//

import UIKit

struct PlayContent: Codable {
    enum CodingKeys: String, CodingKey {
        case content
        case streamDetails
        case startDuration
        case availabilityId
        case providerId
        case sessionToken
        case licenseURL
        case drmTokenURL
        case fairplayCertificatePath
        case defaultSubtitleLanguageCode
        case persistenceSettings
        case selectedTrailer
        case playerSecurity = "PlayerSecurity"
        case clearLeadDuration
    }
    var content: Content?
    var selectedTrailer: Trailer?
    var streamDetails: StreamDetails?
    var startDuration: Double?
    var availabilityId: String?
    var providerId: String?
    var sessionToken: String?
    var licenseURL: String?
    var drmTokenURL: String?
    var fairplayCertificatePath: String?
    var defaultSubtitleLanguageCode: String?
    var persistenceSettings: [String: String]?
    var playerSecurity: String?
    var clearLeadDuration: Int?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try? container.decodeIfPresent(Content.self, forKey: .content)
        selectedTrailer = try? container.decodeIfPresent(Trailer.self, forKey: .selectedTrailer)
        streamDetails = try? container.decodeIfPresent(StreamDetails.self, forKey: .streamDetails)
        startDuration = try? container.decodeIfPresent(Double.self, forKey: .startDuration)
        availabilityId = try? container.decodeIfPresent(String.self, forKey: .availabilityId)
        providerId = try? container.decodeIfPresent(String.self, forKey: .providerId)
        sessionToken = try? container.decodeIfPresent(String.self, forKey: .sessionToken)
        licenseURL = try? container.decodeIfPresent(String.self, forKey: .licenseURL)
        drmTokenURL = try? container.decodeIfPresent(String.self, forKey: .drmTokenURL)
        fairplayCertificatePath = try? container.decodeIfPresent(String.self, forKey: .fairplayCertificatePath)
        defaultSubtitleLanguageCode = try? container.decodeIfPresent(String.self, forKey: .defaultSubtitleLanguageCode)
        persistenceSettings = try? container.decodeIfPresent([String: String].self, forKey: .persistenceSettings)
        playerSecurity = try? container.decodeIfPresent(String.self, forKey: .playerSecurity)
        clearLeadDuration = try? container.decodeIfPresent(Int.self, forKey: .clearLeadDuration)
    }
    func fetchPersistenceSettings() -> (String, String)? {
        if let persistenceSettings = persistenceSettings, let audio = persistenceSettings["audio"], let subtitle = persistenceSettings["subtitle"] {
            return (audio, subtitle)
        }
        return nil
    }
}
