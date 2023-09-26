//
//  PlaybackSpeedTableHeaderView.swift
//  VLIVE-TableView
//
//  Created by Siba on 19/03/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//
import UIKit

class PlaybackSpeedTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        setHeaderUI()
    }
    // MARK: Set UI style in header label
    private func setHeaderUI() {
        headerLabel.textColor = Color.textPrimary.value
        headerLabel.font = Font.boldH4.value
        self.contentView.backgroundColor = Color.background.value
    }
}
