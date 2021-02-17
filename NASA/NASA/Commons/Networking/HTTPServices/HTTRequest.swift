//
//  HTTRequest.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

struct HTTRequest<T : Codable> {
    
    typealias HTTPNewtorkingSuccess  = (T?)-> Swift.Void
    typealias HTTPNewtorkingFailure  = (NSError)-> Swift.Void
    typealias HTTPNetworkingDataTask = (Data?, URLResponse?, Error?)-> Swift.Void
    
    var requestable : HTTPRequestable
    
    func get(success : @escaping HTTPNewtorkingSuccess, failure : @escaping HTTPNewtorkingFailure) {
        var request = URLRequest(url: requestable.url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = requestable.headers
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            self.responseHandler(success: success, failure: failure)(data, response, error)
        }
        session.resume()
    }
    
    func post(success : @escaping HTTPNewtorkingSuccess, failure : @escaping HTTPNewtorkingFailure) {
        
        var request = URLRequest(url: requestable.url)
        request.httpMethod  = "POST"
        request.httpBody    = try? JSONSerialization.data(withJSONObject: requestable.params, options: .prettyPrinted)
        request.allHTTPHeaderFields = requestable.headers
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.responseHandler(success: success, failure: failure)(data, response, error)
        }
        session.resume()
    }
    
    private func responseHandler(success : @escaping HTTPNewtorkingSuccess, failure : @escaping HTTPNewtorkingFailure)-> HTTPNetworkingDataTask {
        return { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    failure(error! as NSError)
                    return
                }
            }
            
            do {
                let decoder = JSONDecoder()
                let json = try data.map {
                    return try decoder.decode(T.self, from: $0)
                }
                DispatchQueue.main.async {
                    success(json)
                }
            }catch let error {
                DispatchQueue.main.async {
                    print(error)
                    failure(error as NSError)
                }
            }
        }
    }
}

