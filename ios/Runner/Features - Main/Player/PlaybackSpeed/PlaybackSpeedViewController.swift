//
//  PlaybackSpeedViewController.swift
//  VLIVE
//
//  Created by Vikesh on 11/12/20.
//  Copyright © 2020 Mobiotics. All rights reserved.
//

import UIKit

class PlaybackSpeedViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        }
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    private var playbackSpeeds: [Float] = [0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]
    var selectedPlaybackRate: Float = 1
    var returnDidSelectPlaybackRate: ((Float) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            tableViewHeight.constant = tableView.contentSize.height
        }
    }
    private func setUI() {
        containerView.backgroundColor = Color.background.value
        closeButton.setImage(UIImage(named: "ic_close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = Color.textSecondary.value
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        containerView.roundCorners(radius: 4)
    }
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: { [weak self] in
            self?.returnDidSelectPlaybackRate?(self?.selectedPlaybackRate ?? 1)
        })
    }
}
extension PlaybackSpeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playbackSpeeds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "PlayBackSpeedTableViewCell"
        tableView.register(UINib(nibName: "PlayBackSpeedTableViewCell", bundle: Bundle(for: PlayBackSpeedTableViewCell.self)), forCellReuseIdentifier: cellReuseIdentifier)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? PlayBackSpeedTableViewCell else { return UITableViewCell() }
        let rate = playbackSpeeds[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.text = rate == 1 ? HardCodedText.normal.localized : "\(rate)x"
        if selectedPlaybackRate == rate {
            cell.selectionIcon.image = #imageLiteral(resourceName: "SelectionTick")
            cell.titleLabel.textColor = Color.textPrimary.value
            cell.titleLabel.font = Font.boldH3.value
        } else {
            cell.selectionIcon.image = UIImage()
            cell.titleLabel.textColor = Color.textSecondary.value
            cell.titleLabel.font = Font.regularH3.value
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.register(UINib(nibName: "PlaybackSpeedTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "PlaybackSpeedTableHeaderView")
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlaybackSpeedTableHeaderView") as? PlaybackSpeedTableHeaderView else { return UITableViewHeaderFooterView() }
        headerView.headerLabel.text = HardCodedText.playbackSpeed.localized
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaybackRate = playbackSpeeds[indexPath.row]
        tableView.reloadData()
    }
}
