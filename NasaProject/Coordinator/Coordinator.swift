//
//  Coordinator.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import UIKit

enum TransitionType {
    case root
    case push
    case modal(UIModalPresentationStyle = .pageSheet)
    case detail
}

//handles all the navigation flow
final class Coordinator {

    private(set) weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func start() {
        let feedPresenter = FeedPresenter(nasaService: NasaService())
        window?.rootViewController = Scene.feed(feedPresenter).viewController(coordinator: self)
    }

    func transition(from: UIViewController, to scene: Scene, type: TransitionType) {
        let viewController = scene.viewController(coordinator: self)

        switch type {
        case .root:
            window?.rootViewController = viewController
        case .push:
            guard let navigationController = from.navigationController else {
                print("ERROR: can not present vc without a current navigation")
                return
            }

            viewController.presentationController?.delegate = from.presentationController?.delegate

            navigationController.pushViewController(viewController, animated: true)
        case .modal(let modalStyle):

            if let originController = from as? UIAdaptivePresentationControllerDelegate {
                var destinationController = viewController

                if let navController = viewController as? UINavigationController {
                    navController.presentationController?.delegate = originController
                    destinationController = navController.viewControllers.first ?? destinationController
                }

                destinationController.presentationController?.delegate = originController
            }

            viewController.modalPresentationStyle = modalStyle
            from.present(viewController, animated: true)
        case .detail:
            guard let splitController = from.splitViewController else {
                print("ERROR: can not present vc without a current navigation")
                return
            }
            splitController.showDetailViewController(viewController, sender: nil)
        }
    }
}
