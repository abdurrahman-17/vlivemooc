//
//  PlayerSettingOptionsTableViewCell.swift
//  MOBIPlayer
//
//  Created by Sasikumar on 31/07/19.
//  Copyright © 2019 Sasikumar. All rights reserved.
//

import UIKit

class PlayerSettingOptionsTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.tintColor = Color.brandColor.value
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
