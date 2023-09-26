//
//  PlayBackSpeedTableViewCell.swift
//  VLIVE
//
//  Created by Vikesh on 11/12/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//

import UIKit

class PlayBackSpeedTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionIcon.tintColor = Color.brandColor.value
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
