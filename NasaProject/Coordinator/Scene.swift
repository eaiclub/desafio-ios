//
//  Scene.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import UIKit

//Each ViewController has a correspondent Scene witch holds its presenter
enum Scene {
    case feed(FeedPresenter)

    func viewController(coordinator: Coordinator) -> UIViewController {
        switch self {
        case .feed(let presenter):
            return FeedViewController(coordinator: coordinator, presenter: presenter)
        }
    }
}
