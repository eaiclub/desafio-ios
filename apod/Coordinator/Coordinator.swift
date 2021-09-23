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
