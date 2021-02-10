//
//  Util.swift
//  NasaList
//
//  Created by Felipe Bastos on 20/11/20.
//

import UIKit
import Lottie
import RKDropdownAlert

class Util {
    static var baseView: UIView = UIView()
    static var backgroundView: UIView = UIView()
    static let animationView = AnimationView(name: "planet")
    
    //------------------------------------------------------------
    //    HUD
    //------------------------------------------------------------
    
    public static func showHUD(in view: UIView) {
        
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
        
        animationView.stop()
        baseView.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
    
    //------------------------------------------------------------
    //    Messages
    //------------------------------------------------------------
    
    static func showMessage(_ message: String?, type : MessageType) {
        
        if let text = message, !text.isEmpty {
            Util.showMessage(title: "", message: message, type: type)
        }
    }
    
    static func showMessage(title: String?, message: String?, type : MessageType) {
        
        var backgroundColor: UIColor?
        var textColor: UIColor?
        
        switch type {
            
        case .success:
            backgroundColor = UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.0)
            textColor = UIColor(red:0.94, green:0.95, blue:0.96, alpha:1.0)
            break
            
        case .warning:
            backgroundColor = UIColor(red:1.00, green:0.78, blue:0.02, alpha:1.0)
            textColor = UIColor(red:0.36, green:0.14, blue:0.08, alpha:1.0)
            break
            
        case .error:
            backgroundColor = UIColor(red:0.88, green:0.10, blue:0.19, alpha:1.0)
            textColor = UIColor(red:0.94, green:0.95, blue:0.96, alpha:1.0)
            break
        }
        
        RKDropdownAlert.title(title, message: message, backgroundColor: backgroundColor, textColor: textColor)
    }
}
