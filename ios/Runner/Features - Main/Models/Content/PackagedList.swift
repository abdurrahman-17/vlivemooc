//
//  PackagedList.swift
//
//  Created by Sasikumar on 07/08/20
//  Copyright (c) Mobiotics. All rights reserved.
//

import Foundation

class PackagedList: Codable {
    enum CodingKeys: String, CodingKey {
        case audio
        case video
        case scrubbing
    }
    var audio: [Media]?
    var video: [Media]?
    var scrubbing: [Scrubbing]?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        audio = try? container.decodeIfPresent([Media].self, forKey: .audio)
        video = try? container.decodeIfPresent([Media].self, forKey: .video)
        scrubbing = try? container.decodeIfPresent([Scrubbing].self, forKey: .scrubbing)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(audio, forKey: .audio)
        try container.encode(video, forKey: .video)
        try container.encode(scrubbing, forKey: .scrubbing)
    }
}
