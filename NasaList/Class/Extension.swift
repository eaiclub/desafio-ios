//
//  Extension.swift
//  NasaList
//
//  Created by Felipe Bastos on 19/11/20.
//

import Foundation
import UIKit

//-----------------------------------------------------------------------
//    MARK: REQUEST
//-----------------------------------------------------------------------

extension Dictionary {
    
    func buildQueryString() -> String {
        
        var urlVars:[String] = []
        
        for (key, value) in self {
            
            if value is Array<Any> {
                
                for v in value as! Array<Any> {
                    
                    if let encodedValue = "\(v)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                        urlVars.append((key as! String) + "[]=" + encodedValue)
                    }
                }
            }else{
                
                if let val = value as? String {
                    if let encodedValue = val.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                        urlVars.append((key as! String) + "=" + encodedValue)
                    }
                }else{
                    urlVars.append((key as! String) + "=\(value)")
                }
            }
        }
        
        return urlVars.isEmpty ? "" : "&" + urlVars.joined(separator: "&")
    }
}

extension URLResponse {
    
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

//-----------------------------------------------------------------------
//    MARK: REQUEST
//-----------------------------------------------------------------------

extension UIView {
    
    func setGradientBackgroundUpDown(bottomColor: UIColor, topColor: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [bottomColor.cgColor, topColor.cgColor]
        gradientLayer.locations = [0.0, 1.4]
        gradientLayer.startPoint = CGPoint(x: -0.6, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackgroundLeftRight(rightColor: UIColor, leftColor: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [rightColor.cgColor, leftColor.cgColor]
        gradientLayer.locations = [0.2, 0.8]
        gradientLayer.startPoint = CGPoint(x: 0.9, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
