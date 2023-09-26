//
//  Trailer.swift
//
//  Created by Hiren on 17/10/19
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Trailer: Codable {
    enum CodingKeys: String, CodingKey {
        case pgrating
        case filelist
        case trailerid
        case duration
        case quality
        case trailertype
        case posterid
        case title
        case poster
    }
    var pgrating: String?
    var filelist: [Filelist]?
    var trailerid: String?
    var duration: Int?
    var quality: String?
    var trailertype: String?
    var posterid: String?
    var title: String?
    var poster: Poster?
    weak var content: Content? // local
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pgrating = try? container.decodeIfPresent(String.self, forKey: .pgrating)
        filelist = try? container.decodeIfPresent([Filelist].self, forKey: .filelist)
        trailerid = try? container.decodeIfPresent(String.self, forKey: .trailerid)
        duration = try? container.decodeIfPresent(Int.self, forKey: .duration)
        quality = try? container.decodeIfPresent(String.self, forKey: .quality)
        trailertype = try? container.decodeIfPresent(String.self, forKey: .trailertype)
        posterid = try? container.decodeIfPresent(String.self, forKey: .posterid)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        poster = try? container.decodeIfPresent(Poster.self, forKey: .poster)
    }
    func fetchImageURL() -> String? {
        let sdImage = poster?.filelist?.filter({ (file) -> Bool in
            return file.quality == "SD"
        }).first?.filename
        let lowImage = poster?.filelist?.filter({ (file) -> Bool in
            return file.quality == "LOW"
        }).first?.filename
        let thumbnail = poster?.filelist?.filter({ (file) -> Bool in
            return file.quality == "THUMBNAIL"
        }).first?.filename
        return sdImage ?? lowImage ?? thumbnail
    }
    func suitableTrailerURL() -> String? {
        let sdTrailer = filelist?.filter({ (file) -> Bool in
            return file.quality == "SD"
        }).first?.filename
        let hdTrailer = filelist?.filter({ (file) -> Bool in
            return file.quality == "HD"
        }).first?.filename
        return sdTrailer ?? hdTrailer
    }
    func suitableTrailerQuality() -> String! {
        return filelist?.contains(where: { (file) -> Bool in
            return file.quality == "SD"
        }) == true ? "SD" : "HD"
    }
    func durationFormatted() -> String? {
        let totalSeconds = Float(duration ?? 0)
        let seconds: Int = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        let minutes: Int = Int((totalSeconds / 60).truncatingRemainder(dividingBy: 60))
        let hours: Int = Int(totalSeconds / 3600)
        if hours == 0 {
            if minutes == 0 {
                return String(format: "%02ds", seconds)
            } else if seconds == 0 {
                return String(format: "%02dm", minutes)
            }
            return String(format: "%02dm %02ds", minutes, seconds)
        }
        return String(format: "%02dhr %02dm", hours, minutes)
    }
}
