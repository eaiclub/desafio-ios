//
//  ApodListSkeleton.swift
//  apod
//
//  Created by rafael.rollo on 28/09/21.
//

import UIKit
import Lottie

class ApodListSkeleton: UIView {

    private lazy var headerSkeletonView: AnimationView = {
        let view = AnimationView(name: "HeaderSkeleton")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.animationSpeed = 0.7
        view.play()
        return view
    }()
    
    private lazy var listSkeletonView: AnimationView = {
        let view = AnimationView(name: "SkeletonRect")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        view.animationSpeed = 1.2
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = ApodCell.LayoutProps.radius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.play()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopLoading() {
        headerSkeletonView.stop()
        headerSkeletonView.removeFromSuperview()
        
        listSkeletonView.stop()
        listSkeletonView.removeFromSuperview()
    }
}

extension ApodListSkeleton: ViewCode {
    func addTheme() {
        backgroundColor = .systemBackground
    }
    
    func addViews() {
        addSubview(headerSkeletonView)
        addSubview(listSkeletonView)
    }
    
    func addConstraints() {
        headerSkeletonView.constrainHeight(to: AllPhotosHeaderView.LayoutProps.height)
        headerSkeletonView.constrainToTopAndSides(of: self, horizontalMargins: 24, notchSafe: true)
        
        listSkeletonView.anchorBelow(of: headerSkeletonView, withMargin: 24)
        listSkeletonView.constrainToBottomAndSides(of: self)
    }
}
