//
//  Color.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 10/01/21.
//

import UIKit

enum Color {
    static var background: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
