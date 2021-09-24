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
        static let dateLabelHeight: CGFloat = 40
    }
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }()
    
    private lazy var daylabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 20)
        label.textColor = .systemBackground
        return label
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 14)
        label.textColor = .systemBackground
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [daylabel, monthLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 8
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        view.backgroundColor = .tertiaryLabel.withAlphaComponent(0.2)
        view.layer.masksToBounds = false
        view.layer.cornerRadius = LayoutProps.dateLabelHeight / 2
        return view
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
        layer.zPosition = CGFloat(position)
        
        daylabel.text = getDay(of: post.date)
        monthLabel.text = formatted(monthDate: post.date)
    }
    
    private func formatted(monthDate: Date) -> String {
        return PostCell.dateFormatter.string(from: monthDate)
    }
    
    private func getDay(of date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        return String(day)
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
        addSubview(dateStackView)
    }
    
    func addConstraints() {
        dateStackView.constrainHeight(to: LayoutProps.dateLabelHeight)
        dateStackView.constrainToTopAndLeading(of: self, topMargin: 24, leadingMargin: 24)
    }
}
