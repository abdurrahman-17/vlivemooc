//
//  PlayerViewController+Scrubbing.swift
//  VLIVE
//
//  Created by Debashish Das on 16/09/22.
//  Copyright © 2022 Mobiotics. All rights reserved.
//

import UIKit
#if MOBIRELEASE
import MOBIPlayerRelease
#endif
#if MOBIDEBUG
import MOBIPlayer
#endif

extension PlayerViewController {
    func createScrubbingModel(_ streamDetails: StreamDetails?, scrubbingImageData: Data? = nil) -> MOBISeekThumbnail? {
        guard let scrubbingModel = streamDetails?.packagedList?.scrubbing?.first else { return nil }
        var seekThumbnail: MOBISeekThumbnail?
        var scrubbingImageUrl: String?
        var scrubbingImage: UIImage?
        if let scrubbingData = scrubbingImageData {
            scrubbingImage = UIImage(data: scrubbingData)
        } else if let fileName = scrubbingModel.seekThumbnailImagePath,
                  let videoURL = URL(string: streamDetails?.streamfilename ?? "") {
            let imageUrl = videoURL.deletingLastPathComponent().appendingPathComponent(fileName)
            scrubbingImageUrl = imageUrl.absoluteString
        }
        let width: CGFloat = Constant.isIpad ? 200 : 140
        seekThumbnail = MOBISeekThumbnail(url: scrubbingImageUrl,
                                      image: scrubbingImage,
                                      total: scrubbingModel.total?.toInt(),
                                      column: scrubbingModel.column?.toInt(),
                                      row: scrubbingModel.row?.toInt(),
                                          width: scrubbingModel.width?.toInt(), height: scrubbingModel.height?.toInt(),
                                      interval: scrubbingModel.interval?.toInt(),
                                      imageViewSize: CGSize(width: width, height: width * 0.56))
        return seekThumbnail
    }
}
