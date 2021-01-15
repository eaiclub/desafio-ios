//
//  SceneController.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import UIKit

//view controllers must conform to this protocol
protocol SceneViewController {
    associatedtype T: Presenter

    var presenter: T { get }
    var coordinator: Coordinator { get }

    init(coordinator: Coordinator, presenter: T)
}

extension SceneViewController where Self: UIViewController {

    func transition(to scene: Scene, type: TransitionType) {
        coordinator.transition(from: self, to: scene, type: type)
    }

    func embedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
