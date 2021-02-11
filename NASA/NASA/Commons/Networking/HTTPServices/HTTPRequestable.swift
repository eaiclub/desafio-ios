//
//  HTTPRequestable.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

protocol HTTPRequestable : HTTPDomain {
    
    var path : String { get }
    
    var url  : URL { get }
    
    var params : [String : Any] { get }
}

extension HTTPRequestable {
    
    var headers : [String : String] {
        return ["Content-Type" : "application/json", "Accept" : "application/json"]
    }
}

