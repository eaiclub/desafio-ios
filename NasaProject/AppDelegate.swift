//
//  AppDelegate.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupWindow()

        return true
    }

    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let coordinator = Coordinator(window: window)
        coordinator.start()
    }
}

