//
//  ApodCoordinator.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import UIKit

class ApodCoordinator: StackCoordinator {
    
    var rootViewController: UIViewController?
    var navigationController: UINavigationController
    
    private var apod: Apod
    
    init(with apod: Apod, navigationController: UINavigationController = UINavigationController()) {
        self.apod = apod
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let controller = ApodViewController(presenting: apod)
        controller.flowCoordinatorDelegate = self
        
        rootViewController = controller
        return controller
    }
    
}

extension ApodCoordinator: ApodFlowCoordinatorDelegate {
    
    func apodViewController(_ controller: ApodViewController, didPressBackButton sender: UIButton) {
        navigationController.popViewController(animated: true)
    }
    
}
