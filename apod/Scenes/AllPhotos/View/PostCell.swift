//
//  PostViewCell.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit
import Lottie

class PostCell: UICollectionViewCell, ReusableView {
    
    // MARK: static
    struct LayoutProps {
        static let radius: CGFloat = 24
        static let dateLabelHeight: CGFloat = 40
    }
    
    // MARK: - subviews
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
    
    private lazy var loaderView: AnimationView = {
        let animation = AnimationView(name: "Loader")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.contentMode = .scaleToFill
        animation.loopMode = .loop
        animation.animationSpeed = 1.5
        animation.play()
        return animation
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let height: CGFloat = 54
        
        let layer = CAGradientLayer()
        layer.colors = [UIColor.white.withAlphaComponent(0.0).cgColor,
                        UIColor.quaternaryLabel.cgColor]
        layer.frame = CGRect(x: 0, y: bounds.height - height, width: bounds.width, height: height)
        return layer
    }()
    
    // MARK - view lifecycle
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
        monthLabel.text = DateFormatter.format(to: .abbreviatedMonthOfYear, value: post.date)
    }

    private func getDay(of date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        return String(day)
    }
}

// MARK: - view code
extension PostCell: ViewCode {
    func addTheme() {
        backgroundColor = .systemBackground
        layer.masksToBounds = false
        layer.cornerRadius = LayoutProps.radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        layer.insertSublayer(gradientLayer, above: layer)
    }
    
    func addViews() {
        addSubview(loaderView)
        addSubview(dateStackView)
    }
    
    func addConstraints() {
        loaderView.constrainSize(to: .init(width: 94, height: 94))
        loaderView.anchorToCenter(of: self)
        
        dateStackView.constrainHeight(to: LayoutProps.dateLabelHeight)
        dateStackView.constrainToTopAndLeading(of: self, topMargin: 24, leadingMargin: 24)
    }
}
