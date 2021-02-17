//
//  HTTPEnvironment.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

enum HTTPEnvironment {
    case dev
    
    
    public var host : String {
        switch self {
        case .dev:
            return "https://api.nasa.gov/"
        }
    }
}
