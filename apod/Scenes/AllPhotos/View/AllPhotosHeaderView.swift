//
//  HeaderView.swift
//  apod
//
//  Created by rafael.rollo on 26/09/21.
//

import UIKit

class AllPhotosHeaderView: UICollectionReusableView, ReusableView {
    
    struct LayoutProps {
        static let height: CGFloat = 200
    }
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "Logo")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .galada(size: 36)
        label.textColor = .label
        label.text = "Apod"
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(.bold, size: 16)
        label.textColor = .label
        label.text = "Astronomy Picture of the Day"
        return label
    }()
    
    private lazy var titlesView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [logoLabel, titleLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var superiorStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [logoImageView, titlesView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 12)
        label.textColor = .secondaryLabel
        label.text = "Discover the cosmos! Each day a different image or photograph of our fascinating universe is featured, along with a brief explanation written by a professional astronomer."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            superiorStackView,
            descriptionLabel
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AllPhotosHeaderView: ViewCode {
    func addTheme() {
        backgroundColor = .clear
    }
    
    func addViews() {
        addSubview(containerView)
    }
    
    func addConstraints() {
        self.constrainHeight(to: LayoutProps.height)
        
        containerView.constrainTo(edgesOf: self)
    }
}
