//
//  UIView+Extensions.swift
//  MOBIPlayer-Noor-Clone
//
//  Created by Sasikumar D on 20/04/23.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    public func addViewTo(_ superView:UIView,
                          leading: CGFloat = 0,
                          trailing: CGFloat = 0,
                          top: CGFloat = 0,
                          bottom: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = superView.bounds
        superView.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1.0, constant: leading).isActive = true
        NSLayoutConstraint(item: superView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trailing).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: top).isActive = true
        NSLayoutConstraint(item: superView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: bottom).isActive = true
    }
    func showLoader(_ color: UIColor = Color.textPrimary.value, topPosition: CGFloat? = nil, style: UIActivityIndicatorView.Style = .whiteLarge) {
        self.stopLoader()
        let spinner = UIActivityIndicatorView(style: style)
        spinner.tintColor = color
        spinner.color = color
        spinner.tag = 9999
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.center = self.center
        self.addSubview(spinner)
        if let topPosition = topPosition {
            NSLayoutConstraint.activate([
                spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                spinner.topAnchor.constraint(equalTo: self.topAnchor, constant: topPosition)
            ])
        } else {
            NSLayoutConstraint.activate([
                spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
    }
    func stopLoader() {
        if let loader = self.viewWithTag(9999) {
            loader.removeFromSuperview()
        }
    }
}
