//
//  AllPhotosCoordinator.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class AllPhotosCoordinator: StackCoordinator {
    
    var rootViewController: UIViewController?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let controller = AllPhotosViewController()
        
        navigationController.setViewControllers([controller], animated: false)
        navigationController.isNavigationBarHidden = true
        
        rootViewController = controller
        return navigationController
    }
    
}
