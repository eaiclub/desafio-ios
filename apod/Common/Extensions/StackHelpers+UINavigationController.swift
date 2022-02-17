//
//  StackHelpers+UINavigationController.swift
//  apod
//
//  Created by rafael.rollo on 29/09/21.
//

import UIKit

extension UINavigationController {
    
    func previousViewController() -> UIViewController? {
        let count = viewControllers.count
        
        guard count > 1 else { return nil }
        return viewControllers[count - 2]
    }
    
}
