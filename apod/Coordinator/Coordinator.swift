//
//  Coordinator.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController? { get set }
    
    @discardableResult func start() -> UIViewController
}

protocol Tab {
    func getTabBarItem() -> UITabBarItem
}

protocol TabsCoordinator: Coordinator {
    var childCoordinators: [StackCoordinator] { get set }
    
    func moveTo(_ tab: Tab)
}

protocol StackCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
    
    var relatedTab: Tab? { get }
    var parentCoordinator: TabsCoordinator? { get set }
}

