//
//  UITableViewExtension.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T : UITableViewCell>(class name : T.Type) {
        register(UINib(nibName: String(describing: name), bundle: Bundle(for: T.classForCoder())), forCellReuseIdentifier: String(describing: name))
    }
    
    func dequeue<T : UITableViewCell>(cell : T.Type, indexPath : IndexPath)-> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
    }
}
