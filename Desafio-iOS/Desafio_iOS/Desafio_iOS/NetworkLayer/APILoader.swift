//
//  APILoader.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import Foundation
import Alamofire

class APILoader<T: APIHandler>{
    
    let apiRequest: T
    
    init(apiRequest: T) {
        self.apiRequest = apiRequest
    }

    func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (Array<T.ResponseDataType>?, Error?) -> ()){
        
        
        if let urlRequest = apiRequest.makeRequest(from: requestData){
            
            AF.request(urlRequest).responseJSON { (response) in
                
                guard let data = response.data, let httpResponse = response.response else {
                    return completionHandler(nil, response.error)
                }
                
                do{
                    let parsedResponse = try self.apiRequest.parseResponse(data: data, response: httpResponse)
                    completionHandler(parsedResponse,nil)
                    
                } catch{
                    completionHandler(nil,error)
                }
                
                
            }
            
        }
    }
    
    
    
}
