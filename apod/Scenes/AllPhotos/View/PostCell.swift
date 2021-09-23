//
//  PostViewCell.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    struct LayoutProps {
        static let radius: CGFloat = 24
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with color: UIColor, forPosition position: Int) {
        backgroundColor = color
        layer.zPosition = CGFloat(position)
    }
}

extension PostCell: ViewCode {
    func addTheme() {
        layer.masksToBounds = false
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = LayoutProps.radius
    }
}
