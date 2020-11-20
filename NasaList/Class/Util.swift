//
//  Util.swift
//  NasaList
//
//  Created by Felipe Bastos on 20/11/20.
//

import UIKit
import Lottie

class Util {
    static var baseView: UIView = UIView()
    static var backgroundView: UIView = UIView()
    
    public static func showHUD(in view: UIView) {
        
        let animationView = AnimationView(name: "planet")
        
        backgroundView.frame = view.bounds
        backgroundView.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.50)
        
        baseView.frame = CGRect(x: ((UIScreen.main.bounds.size.width - 200) / 2), y: ((UIScreen.main.bounds.size.height - 200) / 2), width: 200, height: 200)
        baseView.backgroundColor = .clear
        baseView.addSubview(animationView)
        
        animationView.frame = baseView.bounds
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(backgroundView)
        view.addSubview(baseView)
    }
    
    public static func hideHUD() {
        baseView.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
}
