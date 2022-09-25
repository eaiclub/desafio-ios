//
//  Theme.swift
//  apod
//
//  Created by rafael.rollo on 25/09/2022.
//

import UIKit

// MARK: - Status Bar background animation support
class StatusBarBackgroundView: UIView, ViewCode {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTheme() {
        backgroundColor = .black
    }
    
    func updateBackground(byChanging alpha: CGFloat) {
        backgroundColor = backgroundColor?.withAlphaComponent(alpha)
    }
}

extension UINavigationController {
    var statusBarBackgroundView: StatusBarBackgroundView? {
        guard let view = view.subviews.last,
              let statusBarBackgroundView = view as? StatusBarBackgroundView else { return nil }

        return statusBarBackgroundView
    }
    
    func installStatusBarBackgroundView() {
        guard statusBarBackgroundView == nil else { return }
        
        let statusBarFrame: CGRect
        
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = StatusBarBackgroundView(frame: statusBarFrame)
        view.addSubview(statusBarView)
    }
}
