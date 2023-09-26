//
//  PlayerSettingsHeaderFooterView.swift
//  VLIVE
//
//  Created by Sasikumar on 14/05/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//

import UIKit

class PlayerSettingsHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        setUI()
    }
    private func setUI() {
        titleLabel.font = Font.boldH3.value
        titleLabel.textColor = Color.textPrimary.value
        titleLabel.superview?.backgroundColor = Color.background.value
    }
}
