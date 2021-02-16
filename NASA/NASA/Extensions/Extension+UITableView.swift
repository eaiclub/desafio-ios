//
//  Extension+UITableView.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 16/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.3921568627, blue: 0.431372549, alpha: 1)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Menlo-Regular", size: 12)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    func register<T : UITableViewCell>(class name : T.Type) {
        register(UINib(nibName: String(describing: name), bundle: Bundle(for: T.classForCoder())), forCellReuseIdentifier: String(describing: name))
    }
    
    func dequeue<T : UITableViewCell>(cell : T.Type, indexPath : IndexPath)-> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
    }
}
