//
//  Extension+UIView.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 16/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

extension UIView {
    
    func setErrorMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.3921568627, blue: 0.431372549, alpha: 1)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Menlo-Regular", size: 12)
        self.addSubview(messageLabel)
    }
    
    func showLoading() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .blue
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        self.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
