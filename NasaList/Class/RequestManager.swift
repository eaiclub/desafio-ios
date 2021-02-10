//
//  RequestManager.swift
//  NasaList
//
//  Created by Felipe Bastos on 19/11/20.
//

import Foundation

class RequestManager {
    
    func loadData(date: String, _ completion: @escaping (_ success : Bool, _ response: Post?, _ message: String?) -> Void) {
    
        let endpoint = ""
        let param = ["date" : date]
    
        MockSession().request(method: .get, endpoint: endpoint, parameters: param, responseType: Post.self) { (response, code) in
            
            if let object = response as? Post, code == 200 {
                completion(true, object, "")
            }else{
                completion(false, nil, Constants.Messages.unknownError)
            }
        }
    }
}
