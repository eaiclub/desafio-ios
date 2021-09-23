//
//  TabNavigationCoordinator.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class TabBarCoordinator: NSObject, TabsCoordinator {
        
    enum BottomTab: String, Tab {
        case allPhotos
        case apod
        
        func getTabBarItem() -> UITabBarItem {
            switch self {
            case .allPhotos:
                return UITabBarItem(
                    title: "All Photos",
                    image: UIImage(named: "AllPhotosIcon"),
                    tag: 0
                )
                
            case .apod:
                return UITabBarItem(
                    title: "Apod",
                    image: UIImage(named: "ApodIcon"),
                    tag: 1
                )
            }
        }
    }
    
    var rootViewController: UIViewController?
    
    lazy var childCoordinators: [StackCoordinator] = [
        AllPhotosCoordinator(),
        ApodCoordinator()
    ]
    
    func start() -> UIViewController {
        var viewControllers: [UIViewController] = []
        
        childCoordinators.forEach { coordinator in
            let rootViewController = coordinator.start()
            rootViewController.tabBarItem = coordinator.relatedTab?.getTabBarItem()
            
            coordinator.parentCoordinator = self
            viewControllers.append(rootViewController)
        }
        
        let tabBarController = BaseTabBarController()
        tabBarController.viewControllers = viewControllers
        
        rootViewController = tabBarController
        return tabBarController
    }
    
    func moveTo(_ tab: Tab) {
        let tabBarController = rootViewController as? UITabBarController
        tabBarController?.selectedIndex = tab.getTabBarItem().tag
    }
}
