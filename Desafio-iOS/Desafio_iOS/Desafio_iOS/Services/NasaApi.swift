//
//  NasaApi.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import Foundation

struct NasaAPI: APIHandler{
    
    func makeRequest(from param: KeyValuePairs<Any, Any>) -> URLRequest? {
        
        let urlString = CONSTANTS.BASE_URL
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }

    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [NasaData]? {
        return try defaultParseResponse(data: data,response: response)
    }
    
}
