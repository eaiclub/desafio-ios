//
//  HomeWorkerRequestable.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

struct HomeWorkerRequestable : HTTPRequestable {
    
    var request : HomeModels.Planetarium.Request
    
    var url: URL {
        return URL(string: environment.host + path)!
    }
    
    var path: String {
        return "planetary/apod?api_key=\(token)&count=50"
    }
    
    var token: String {
        return "4wH4qBZ0hROeKVHHE5oK4RWsLrrSovjXG0nqaqyE"
    }
    
    var params: [String : Any] {
        return [:]
    }
}
