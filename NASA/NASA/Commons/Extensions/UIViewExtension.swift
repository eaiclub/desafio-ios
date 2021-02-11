//
//  UIViewExtension.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

extension UIView {
    
    func xib() {
        let bundle  = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let view = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil).first as! UIView
        switch bounds {
        case .zero:
            frame = view.bounds
        default:
            view.frame = bounds
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        view.layoutIfNeeded()
    }
}
