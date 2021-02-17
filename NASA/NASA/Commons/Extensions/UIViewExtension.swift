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

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UIView {
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {
    func addHeightConstaintOrUpdate(constant : CGFloat) {
        if let constraint = (self.constraints.filter({$0.identifier == "height"}).first) {
            constraint.constant = constant
            self.frame.size.height = constant
        }else {
            self.frame.size.height = constant
            let heightConstraint = heightAnchor.constraint(equalToConstant: frame.size.height)
            heightConstraint.identifier = "height"
            heightConstraint.priority   = UILayoutPriority(250)
            heightConstraint.isActive   = true
        }
        self.setNeedsLayout()
        self.invalidateIntrinsicContentSize()
    }
}
