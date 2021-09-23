//
//  ApplicationCoordinator.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    
    var window: UIWindow
    
    var rootViewController: UIViewController? {
        didSet {
            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil
            )
            
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    @discardableResult func start() -> UIViewController {
        let initialViewController = LaunchScreenViewController(delegate: self)
        
        rootViewController = initialViewController
        return initialViewController
    }

}

extension ApplicationCoordinator: LaunchScreenViewControllerDelegate {
    func launchScreenAnimationDidFinish(_ launchScreen: LaunchScreenViewController) {
        rootViewController = UIViewController()
    }
}
