//
//  MockSession.swift
//
//  Created by Felipe Bastos on 10/11/20.
//

import Foundation

class MockSession {
    let session = URLSession.shared
    let request = NSMutableURLRequest()
    
    func request<T:Decodable>(method: RequestType, endpoint: String, parameters: Dictionary<String, Any>, responseType: T.Type, completion: @escaping (_ response: Any?, _ code: Int) -> Void) {
        
        let key: String = "QBH0Z2pOyTPdbCIPRlfg9gnzqsFueZ9SLKklAqCE"
        
        let baseURL = "https://api.nasa.gov/planetary/apod/?api_key=\(key)"
        
        var serverURL: String = baseURL + endpoint
        
        switch method {
        case .get:
            serverURL += parameters.buildQueryString()
            request.httpMethod = "GET"
            break
        default:
            break
        }
        
        request.url = URL(string: serverURL)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            let responseCode = response?.getStatusCode() ?? 0
            
            if error != nil {
                print(error.debugDescription )
                return
            }
            
            do {
                let json = try JSONDecoder().decode(responseType, from: data!)
                
                DispatchQueue.main.async {
                    completion(json, responseCode)
                }
            } catch {
                print("Error during JSON serialization: \(error)")
                DispatchQueue.main.async {
                    completion(false, responseCode)
                }
            }
            
        })
        task.resume()
    }
}

