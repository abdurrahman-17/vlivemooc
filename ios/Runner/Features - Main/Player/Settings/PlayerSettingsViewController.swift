//
//  SDGSettingsViewController.swift
//  MOBIPlayer
//
//  Created by Sasikumar on 30/07/19.
//  Copyright © 2019 Sasikumar. All rights reserved.
//

import UIKit
import AVKit
#if MOBIRELEASE
import MOBIPlayerRelease
#endif
#if MOBIDEBUG
import MOBIPlayer
#endif
class PlayerSettingsViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var tableViews: [UITableView]!
    @IBOutlet weak var qualityTableView: UITableView!
    @IBOutlet weak var audioTableView: UITableView!
    @IBOutlet weak var subtitleTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    var qualities = [MOBIVideoQuality]()
    var audioLanguages = [AVMediaSelectionOption]()
    var embedSubtitles = [AVMediaSelectionOption]()
    var sideLoadSubtitles = [SideLoadSubtitle]()
    var subtitles = [Any]()
    var selectedSettings: (MOBIVideoQuality?, AVMediaSelectionOption?, Any?)? {
        didSet {
            if let sideloaded = selectedSettings?.2 as? SideLoadSubtitle {
                self.selectedSideLoadSubtitle = sideloaded
            } else if let embed = selectedSettings?.2 as? AVMediaSelectionOption, !embedSubtitles.isEmpty {
                self.selectedEmbedSubtitle = embed
            } else if selectedSettings?.2 == nil {
                self.selectedSideLoadSubtitle = nil
                self.selectedEmbedSubtitle = nil
            }
        }
    }
    var setting: MOBIPlayerSetting?
    private var selectedEmbedSubtitle: AVMediaSelectionOption?
    private var selectedSideLoadSubtitle: SideLoadSubtitle?
    var returnDismiss: (((MOBIVideoQuality?, AVMediaSelectionOption?, Any?)?) -> Void)?
    var currentPresentationHeight: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configureSubtitles()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    private func setUI() {
        backgroundView.backgroundColor = Color.background.value
        closeButton.tintColor = Color.textPrimary.value
        qualityTableView.superview?.isHidden = qualities.isEmpty
        separatorView.isHidden = qualities.isEmpty
        audioTableView.superview?.isHidden = false
        if #available(iOS 15.0, *) {
            qualityTableView.sectionHeaderTopPadding = 0
            audioTableView.sectionHeaderTopPadding = 0
            subtitleTableView.sectionHeaderTopPadding = 0
        }
    }
    private func configureSubtitles() {
        if !embedSubtitles.isEmpty {
            subtitles = embedSubtitles
        } else {
            subtitles = sideLoadSubtitles
        }
        if subtitles.contains(where: { (subtitle) -> Bool in
            return (subtitle as? String) == HardCodedText.off.localized
        }) == false {
            subtitles.insert(HardCodedText.off.localized, at: 0)
        }
        subtitleTableView.reloadData()
    }
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.returnDismiss?(self.selectedSettings)
        })
    }
}
extension PlayerSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 101:
            return qualities.count
        case 102:
            return audioLanguages.count
        case 103:
            return subtitles.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "PlayerSettingOptionsTableViewCell"
        tableView.register(UINib(nibName: "PlayerSettingOptionsTableViewCell", bundle: Bundle(for: PlayerSettingOptionsTableViewCell.self)), forCellReuseIdentifier: cellReuseIdentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? PlayerSettingOptionsTableViewCell else { return UITableViewCell() }
        cell.titleLabel.textColor = Color.textPrimary.value
        switch tableView.tag {
        case 101:
            let quality = qualities[indexPath.row]
            cell.titleLabel.text = quality.title?.localized
            if selectedSettings?.0 === quality || (selectedSettings?.0 == nil && quality.title == "Auto") {
                cell.titleLabel.font = Font.boldH3.value
                cell.iconImageView.image = #imageLiteral(resourceName: "SelectionTick")
                if let height = currentPresentationHeight, quality.title == "Auto" {
                    if let filtered = qualities.filter({ (qual) -> Bool in
                        return CGFloat(qual.height ?? 0) == height
                    }).first, let title = filtered.title, title != "Auto" {
                        let hdText = "(\(title.replacingOccurrences(of: " HD", with: "")))"
                        let qualityText = (quality.title?.localized ?? "")
                        cell.titleLabel.text = qualityText + " " + hdText
                    }
                }
            } else {
                cell.iconImageView.image = UIImage()
                cell.titleLabel.font = Font.regularH3.value
                cell.titleLabel.textColor = Color.textPrimary.value.withAlphaComponent(0.6)
            }
            let nsStringFormat = NSString(string: cell.titleLabel.text ?? "")
            let hdRange = nsStringFormat.range(of: "HD")
            let attributedText = NSMutableAttributedString(string: cell.titleLabel.text ?? "" , attributes:
                                                            [NSAttributedString.Key.font: cell.titleLabel.font ?? Font.regularH3.value,
                                                             NSAttributedString.Key.foregroundColor: cell.titleLabel.textColor ?? Color.textPrimary.value.withAlphaComponent(0.7)])
            attributedText.addAttributes([NSAttributedString.Key.font: cell.titleLabel.font.withSize(Constant.isIpad ? FontIpadSize.h4Size.rawValue : FontSize.h4Size.rawValue),
                                          NSAttributedString.Key.foregroundColor: UIColor.red], range:  hdRange)
            cell.titleLabel.attributedText = attributedText
        case 102:
            let audio = audioLanguages[indexPath.row]
            cell.titleLabel.text = audio.displayName(with: Locale(identifier: UserDefaults.standard.object(forKey: "kLanguage") as? String ?? "en"))
            if selectedSettings?.1 == audio {
                cell.titleLabel.font = Font.boldH3.value
                cell.iconImageView.image = #imageLiteral(resourceName: "SelectionTick")
            } else {
                cell.iconImageView.image = UIImage()
                cell.titleLabel.font = Font.regularH3.value
                cell.titleLabel.textColor = Color.textPrimary.value.withAlphaComponent(0.6)
            }
        case 103:
            var isSelected = false
            var displayName = ""
            if let embedSubtitle = subtitles[indexPath.row] as? AVMediaSelectionOption {
                displayName = embedSubtitle.displayName(with: Locale(identifier: UserDefaults.standard.object(forKey: "kLanguage") as? String ?? "en"))
                isSelected = selectedEmbedSubtitle == embedSubtitle
            } else if let sideLoadedSubtitle = subtitles[indexPath.row] as? SideLoadSubtitle {
                if let localizedDisplayName = NSLocale(localeIdentifier: sideLoadedSubtitle.languageCode).displayName(forKey: NSLocale.Key.identifier, value: sideLoadedSubtitle.languageCode) {
                    displayName = localizedDisplayName
                } else {
                    displayName = sideLoadedSubtitle.displayName
                }
                isSelected = selectedSideLoadSubtitle?.displayName == sideLoadedSubtitle.displayName
            } else if let offString = subtitles[indexPath.row] as? String {
                displayName = offString
                if embedSubtitles.isEmpty && sideLoadSubtitles.isEmpty {
                    isSelected = true
                } else {
                    isSelected = (selectedEmbedSubtitle == nil && !embedSubtitles.isEmpty) || (selectedSideLoadSubtitle == nil && !sideLoadSubtitles.isEmpty)
                }
            }
            cell.titleLabel.text = displayName
            if isSelected {
                cell.titleLabel.font = Font.boldH3.value
                cell.iconImageView.image = #imageLiteral(resourceName: "SelectionTick")
            } else {
                cell.iconImageView.image = UIImage()
                cell.titleLabel.font = Font.regularH3.value
                cell.titleLabel.textColor = Color.textPrimary.value.withAlphaComponent(0.6)
            }
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 103 && section == 1 {
            return 0
        }
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.register(UINib(nibName: "PlayerSettingsHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "PlayerSettingsHeaderFooterView")
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlayerSettingsHeaderFooterView") as? PlayerSettingsHeaderFooterView
        switch tableView.tag {
        case 101:
            headerView?.titleLabel.text = HardCodedText.quality.localized
        case 102:
            headerView?.titleLabel.text = HardCodedText.audio.localized
        case 103:
            headerView?.titleLabel.text = HardCodedText.subtitles.localized
        default:
            break
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 101:
            selectedSettings?.0 = qualities[indexPath.row]
        case 102:
            selectedSettings?.1 = audioLanguages[indexPath.row]
        case 103:
            if let embedSubtitle = subtitles[indexPath.row] as? AVMediaSelectionOption {
                selectedSettings?.2 = embedSubtitle
            } else if let sideLoadedSubtitle = subtitles[indexPath.row] as? SideLoadSubtitle {
                selectedSettings?.2 = sideLoadedSubtitle
            } else if subtitles[indexPath.row] as? String != nil {
                selectedSettings?.2 = nil
            }
        default:
            break
        }
        tableView.reloadData()
    }
}
