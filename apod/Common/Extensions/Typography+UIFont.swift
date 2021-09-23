//
//  Typography+UIFont.swift
//  apod
//
//  Created by rafael.rollo on 22/09/21.
//

import UIKit

extension UIFont {
    static func galada(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Galada-Regular", size: size) else {
            fatalError("Failed to load the Galada font.")
        }
        
        return UIFontMetrics.default.scaledFont(for: font)
    }
}

