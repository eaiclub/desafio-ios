//
//  AppDelegate.swift
//  EAIClub-Challenge
//
//  Created by Rhullian Damião on 25/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow? = {
    return UIWindow()
  }()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    createContext()
    return true
  }
  
  private func createContext() {
    let vc = NASAViewerViewController()
    let window = UIWindow()
    let nav = UINavigationController(rootViewController: vc)
    nav.setNavigationBarHidden(true, animated: false)
    window.rootViewController = nav
    self.window = window
    window.makeKeyAndVisible()
  }
}

