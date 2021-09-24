//
//  PostViewCell.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class PostCell: UICollectionViewCell, ReusableView {
    
    struct LayoutProps {
        static let radius: CGFloat = 24
    }
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        layoutAttributes.frame.size.height = size.height

        layoutIfNeeded()
        return layoutAttributes
    }
    
    func setup(with post: Post, forPosition position: Int) {
        label.text = formatted(date: post.date)
        layer.zPosition = CGFloat(position)
    }
    
    private func formatted(date: Date) -> String {
        return PostCell.dateFormatter.string(from: date)
    }
}

extension PostCell: ViewCode {
    func addTheme() {
        backgroundColor = .systemBackground
        layer.masksToBounds = false
        layer.cornerRadius = LayoutProps.radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func addViews() {
        addSubview(label)
    }
    
    func addConstraints() {
        label.constrainToTopAndSides(of: self, topMargin: 24, horizontalMargins: 24)
    }
}
