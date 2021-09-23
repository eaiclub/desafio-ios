//
//  BaseTabBarController.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabBar.layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
    }

    private func setup() {
        let font = UIFont.openSans(.semibold, size: 10)
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .systemBackground
        
        appearance.stackedLayoutAppearance.normal.iconColor = .tertiaryLabel
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.tertiaryLabel
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .secondaryLabel
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.secondaryLabel
        ]
                
        tabBar.standardAppearance = appearance
        
        tabBar.layer.shadowRadius = 8.0
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowColor = UIColor.secondaryLabel.cgColor
        tabBar.layer.shadowOffset = .init(width: 0, height: -5)
    }
}
