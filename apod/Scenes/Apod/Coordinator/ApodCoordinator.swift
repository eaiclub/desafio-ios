//
//  ApodCoordinator.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class ApodCoordinator: StackCoordinator {
    var navigationController: UINavigationController
    var rootViewController: UIViewController?
    
    var parentCoordinator: TabsCoordinator?
    var relatedTab: Tab? {
        return TabBarCoordinator.BottomTab.apod
    }
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let controller = ApodViewController()
        
        navigationController.setViewControllers([controller], animated: false)
        navigationController.isNavigationBarHidden = true
        
        rootViewController = controller
        return navigationController
    }
}
