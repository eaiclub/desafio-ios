//
//  Extensions+View.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 31/03/21.
//

import Foundation
import UIKit

extension UIView {

    // MARK: Activity Indicator

    func activityIndicator(show: Bool) {
        activityIndicator(show: show, style: .medium)
    }

    func activityIndicator(show: Bool, style: UIActivityIndicatorView.Style) {
        var spinner: UIActivityIndicatorView? = viewWithTag(NSIntegerMax - 1) as? UIActivityIndicatorView

        if spinner != nil {
            spinner?.removeFromSuperview()
            spinner = nil
        }

        if spinner == nil && show {
            spinner = UIActivityIndicatorView.init(style: style)
            spinner?.translatesAutoresizingMaskIntoConstraints = false
            spinner?.hidesWhenStopped = true
            spinner?.tag = NSIntegerMax - 1

            if Thread.isMainThread {
                spinner?.startAnimating()
            } else {
                DispatchQueue.main.async {
                    spinner?.startAnimating()
                }
            }

            insertSubview((spinner)!, at: 0)

            NSLayoutConstraint.init(item: spinner!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint.init(item: spinner!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true

            spinner?.isHidden = !show
        }
    }

}
