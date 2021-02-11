//
//  AppNavigationController.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareLayout()
    }
    
    private func prepareLayout() {
        self.delegate                   = self
        self.navigationBar.tintColor    = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.navigationBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationBar.shadowImage  = UIImage()
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                                                  NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.title = "NASA"
    }
}
