//
//  BaseClass.swift
//
//  Created by Hiren on 17/10/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import UIKit

class Content: Codable {
    enum CodingKeys: String, CodingKey {
        case track
        case thumbnail
        case objectid
        case contentdetails
        case title
        case ratingtype
        case poster
        case duration
        case seriesid
        case objectowner
        case details
        case seasonnum
        case objectstatus
        case bandorartist
        case trailer
        case releasedate
        case jobid
        case subcategory
        case publishtime
        case contentlanguage
        case genre
        case category
        case tags
        case objecttag
        case productionyear
        case imdbid
        case pgrating
        case albumid
        case subgenre
        case longdescription
        case episode
        case objecttype
        case endtime
        case numviews
        case shortdescription
        // Previous Key
        case seasoncount
        case episodenum
        case episodecount
        case seriesname
        case itemlist
        case seasonid
        case albumname
        case trackcount
        case skip
        case defaulttitle
        case defaultgenre
        case advisory
        case castncrew
        case parentid
        case partnerid
        case playlead
    }
    var track: Int?
    var thumbnail: String?
    var objectid: String?
    var contentdetails: [Contentdetails]?
    var title: String?
    var ratingtype: String?
    var poster: [Poster]?
    var duration: Int?
    var seriesid: String?
    var objectowner: String?
    var details: Details?
    var seasonnum: Int?
    var objectstatus: String?
    var bandorartist: String?
    var trailer: [Trailer]?
    var releasedate: String?
    var jobid: String?
    var subcategory: String?
    var publishtime: String?
    var contentlanguage: [String]?
    var genre: String?
    var category: String?
    var shortDescription: String?
    var tags: [String]?
    var objecttag: [String]?
    var productionyear: Int?
    var imdbid: String?
    var pgrating: String?
    var albumid: String?
    var subgenre: [String]?
    var longdescription: String?
    var episode: String?
    var objecttype: String?
    var endtime: String?
    // Previous keys
    var seasoncount: Int?
    var episodenum: Int?
    var episodecount: Int?
    var seriesname: String?
    var itemlist: [String]?
    var seasonid: String?
    var albumname: String?
    var numviews: String?
    var trackcount: Int?
    var skipSetttings: [SkipSettings]?
    public var landscapeImage: UIImage? // Local
    public var squareImage: UIImage? // Local
    var defaulttitle: String?
    var defaultgenre: String?
    var advisory: String?
    var castncrew: CastnCrewDetails?
    var parentid: String?
    var partnerid: String?
    var playlead: String?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        track = try? container.decodeIfPresent(Int.self, forKey: .track)
        thumbnail = try? container.decodeIfPresent(String.self, forKey: .thumbnail)
        objectid = try? container.decodeIfPresent(String.self, forKey: .objectid)
        contentdetails = try? container.decodeIfPresent([Contentdetails].self, forKey: .contentdetails)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        ratingtype = try? container.decodeIfPresent(String.self, forKey: .ratingtype)
        poster = try? container.decodeIfPresent([Poster].self, forKey: .poster)
        duration = try? container.decodeIfPresent(Int.self, forKey: .duration)
        seriesid = try? container.decodeIfPresent(String.self, forKey: .seriesid)
        objectowner = try? container.decodeIfPresent(String.self, forKey: .objectowner)
        details = try? container.decodeIfPresent(Details.self, forKey: .details)
        seasonnum = try? container.decodeIfPresent(Int.self, forKey: .seasonnum)
        objectstatus = try? container.decodeIfPresent(String.self, forKey: .objectstatus)
        bandorartist = try? container.decodeIfPresent(String.self, forKey: .bandorartist)
        trailer = try? container.decodeIfPresent([Trailer].self, forKey: .trailer)
        releasedate = try? container.decodeIfPresent(String.self, forKey: .releasedate)
        jobid = try? container.decodeIfPresent(String.self, forKey: .jobid)
        subcategory = try? container.decodeIfPresent(String.self, forKey: .subcategory)
        publishtime = try? container.decodeIfPresent(String.self, forKey: .publishtime)
        contentlanguage = try? container.decodeIfPresent([String].self, forKey: .contentlanguage)
        genre = try? container.decodeIfPresent(String.self, forKey: .genre)
        category = try? container.decodeIfPresent(String.self, forKey: .category)
        shortDescription = try? container.decodeIfPresent(String.self, forKey: .shortdescription)
        tags = try? container.decodeIfPresent([String].self, forKey: .tags)
        objecttag = try? container.decodeIfPresent([String].self, forKey: .objecttag)
        productionyear = try? container.decodeIfPresent(Int.self, forKey: .productionyear)
        imdbid = try? container.decodeIfPresent(String.self, forKey: .imdbid)
        pgrating = try? container.decodeIfPresent(String.self, forKey: .pgrating)
        albumid = try? container.decodeIfPresent(String.self, forKey: .albumid)
        subgenre = try? container.decodeIfPresent([String].self, forKey: .subgenre)
        longdescription = try? container.decodeIfPresent(String.self, forKey: .longdescription)
        episode = try? container.decodeIfPresent(String.self, forKey: .episode)
        objecttype = try? container.decodeIfPresent(String.self, forKey: .objecttype)
        endtime = try? container.decodeIfPresent(String.self, forKey: .endtime)
        seasoncount = try? container.decodeIfPresent(Int.self, forKey: .seasoncount)
        episodenum = try? container.decodeIfPresent(Int.self, forKey: .episodenum)
        episodecount = try? container.decodeIfPresent(Int.self, forKey: .episodecount)
        seriesname = try? container.decodeIfPresent(String.self, forKey: .seriesname)
        seasonid = try? container.decodeIfPresent(String.self, forKey: .seasonid)
        itemlist = try? container.decodeIfPresent([String].self, forKey: .itemlist)
        albumname = try? container.decodeIfPresent(String.self, forKey: .albumname)
        trackcount = try? container.decodeIfPresent(Int.self, forKey: .trackcount)
        skipSetttings = try? container.decodeIfPresent([SkipSettings].self, forKey: .skip)
        defaulttitle = try? container.decodeIfPresent(String.self, forKey: .defaulttitle)
        defaultgenre = try? container.decodeIfPresent(String.self, forKey: .defaultgenre)
        advisory = try? container.decodeIfPresent(String.self, forKey: .advisory)
        castncrew = try? container.decodeIfPresent(CastnCrewDetails.self, forKey: .castncrew)
        parentid = try? container.decodeIfPresent(String.self, forKey: .parentid)
        partnerid = try? container.decodeIfPresent(String.self, forKey: .partnerid)
        playlead = try? container.decodeIfPresent(String.self, forKey: .playlead)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(numviews, forKey: .numviews)
        try container.encode(track, forKey: .track)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(objectid, forKey: .objectid)
        try container.encode(contentdetails, forKey: .contentdetails)
        try container.encode(title, forKey: .title)
        try container.encode(ratingtype, forKey: .ratingtype)
        try container.encode(poster, forKey: .poster)
        try container.encode(duration, forKey: .duration)
        try container.encode(seriesid, forKey: .seriesid)
        try container.encode(objectowner, forKey: .objectowner)
        try container.encode(details, forKey: .details)
        try container.encode(seasonnum, forKey: .seasonnum)
        try container.encode(objectstatus, forKey: .objectstatus)
        try container.encode(bandorartist, forKey: .bandorartist)
        try container.encode(trailer, forKey: .trailer)
        try container.encode(releasedate, forKey: .releasedate)
        try container.encode(jobid, forKey: .jobid)
        try container.encode(subcategory, forKey: .subcategory)
        try container.encode(publishtime, forKey: .publishtime)
        try container.encode(contentlanguage, forKey: .contentlanguage)
        try container.encode(genre, forKey: .genre)
        try container.encode(category, forKey: .category)
        try container.encode(shortDescription, forKey: .shortdescription)
        try container.encode(tags, forKey: .tags)
        try container.encode(objecttag, forKey: .objecttag)
        try container.encode(productionyear, forKey: .productionyear)
        try container.encode(imdbid, forKey: .imdbid)
        try container.encode(pgrating, forKey: .pgrating)
        try container.encode(albumid, forKey: .albumid)
        try container.encode(subgenre, forKey: .subgenre)
        try container.encode(longdescription, forKey: .longdescription)
        try container.encode(episode, forKey: .episode)
        try container.encode(objecttype, forKey: .objecttype)
        try container.encode(endtime, forKey: .endtime)
        try container.encode(seasoncount, forKey: .seasoncount)
        try container.encode(episodenum, forKey: .episodenum)
        try container.encode(episodecount, forKey: .episodecount)
        try container.encode(seriesname, forKey: .seriesname)
        try container.encode(seasonid, forKey: .seasonid)
        try container.encode(itemlist, forKey: .itemlist)
        try container.encode(albumname, forKey: .albumname)
        try container.encode(trackcount, forKey: .trackcount)
        try container.encode(skipSetttings, forKey: .skip)
        try container.encode(defaulttitle, forKey: .defaulttitle)
        try container.encode(defaultgenre, forKey: .defaultgenre)
        try container.encode(advisory, forKey: .advisory)
        try container.encode(castncrew, forKey: .castncrew)
        try container.encode(parentid, forKey: .parentid)
        try container.encode(partnerid, forKey: .partnerid)
        try container.encode(playlead, forKey: .playlead)
    }
    var displayTitle: String? {
        var title = ""
        if isEpisode {
            if let seasonnum = seasonNumber, !seasonnum.isEmpty {
                title += "\(seasonnum)"
                title += " "
            }
            if let episodenum = episodeNumber, !episodenum.isEmpty {
                title += "\(episodenum)"
            }
        }
        if title != "" {
            title += ": "
        }
        return title + (self.title ?? "")
    }
}
// MARK: - Series Related
extension Content {
    var isEpisode: Bool {
        return objecttype == "CONTENT" && seriesid != nil && episodenum != nil
    }
    var isSeason: Bool {
        return objecttype == "SEASON" && seriesid != nil
    }
    var seasonNumber: String? {
        var title = ""
        if let seasonnum = seasonnum {
            title += "S" + "\(seasonnum)"
        }
        return title
    }
    private var episodeNumber: String? {
        var title = ""
        if let episodenum = episodenum {
            title += "E" + "\(episodenum)"
        }
        return title
    }
    var episodeTitle: String {
        return "\(seriesname ?? "")" + "\n" + "\(seasonNumber ?? "")" + ": " + "\(title ?? "")"
    }
}
// MARK: - Poster Related
extension Content {
    func fetchImageURL(_ displayType: DisplayType?, imageSize: CGSize) -> String? {
        guard let posterArray = poster, let displayType = displayType else { return thumbnail }
        if displayType == .MIXED {
            return fetchImageURL(.LANDSCAPE, imageSize: imageSize) ?? fetchImageURL(.PORTRAIT, imageSize: imageSize) ?? fetchImageURL(.SQUARE, imageSize: imageSize) ?? thumbnail
        } else {
            if let selectedPoster = posterArray.filter({ (poster) -> Bool in
                return poster.postertype == displayType.rawValue
            }).first {
                let sdImage = selectedPoster.filelist?.filter({ (file) -> Bool in
                    return file.quality == "SD"
                }).first?.filename
                let lowImage = selectedPoster.filelist?.filter({ (file) -> Bool in
                    return file.quality == "LOW"
                }).first?.filename
                let thumbnailImage = selectedPoster.filelist?.filter({ (file) -> Bool in
                    return file.quality == "THUMBNAIL"
                }).first?.filename
                let hdImage = selectedPoster.filelist?.filter({ (file) -> Bool in
                    return file.quality == "HD"
                }).first?.filename
                if imageSize == .zero {
                    return sdImage ?? lowImage ?? thumbnailImage ?? hdImage
                } else if displayType == .LANDSCAPE {
                    if imageSize.width <= 256 {
                        return thumbnailImage ?? lowImage ?? sdImage
                    } else if imageSize.width <= 480 {
                        return lowImage ?? sdImage
                    } else if imageSize.width <= 960 {
                        return sdImage
                    } else {
                        return hdImage
                    }
                } else if displayType == .PORTRAIT {
                    if imageSize.width <= 170 {
                        return thumbnailImage ?? lowImage ?? sdImage
                    } else if imageSize.width <= 320 {
                        return lowImage ?? sdImage
                    } else if imageSize.width <= 640 {
                        return sdImage
                    } else {
                        return hdImage
                    }
                } else if displayType == .SQUARE {
                    if imageSize.width <= 256 {
                        return thumbnailImage ?? lowImage ?? sdImage ?? hdImage
                    } else if imageSize.width <= 480 {
                        return lowImage ?? sdImage ?? hdImage
                    } else if imageSize.width <= 960 {
                        return sdImage ?? hdImage
                    } else {
                        return hdImage
                    }
                }
            }
            return thumbnail
        }
    }
    
}
// MARK: - Skip Settings
extension Content {
    func fetchSkipIntro() -> (Double, Double)? {
        if let skipIntro = skipSetttings?.filter({ (settings) -> Bool in
            return settings.skiptype == "INTRO"
        }).first, let start = skipIntro.start, let end = skipIntro.end {
            return (start, end)
        }
        return nil
    }
    func fetchNextEpisode() -> (Double, Double)? {
        if let skipIntro = skipSetttings?.filter({ (settings) -> Bool in
            return settings.skiptype == "CREDITS"
        }).first, let start = skipIntro.start, let end = skipIntro.end {
            return (start, 10) // end hardcoded as for now
        }
        return nil
    }
    var isClearLeadEnabled: Bool {
        return playlead == "YES"
    }
}
