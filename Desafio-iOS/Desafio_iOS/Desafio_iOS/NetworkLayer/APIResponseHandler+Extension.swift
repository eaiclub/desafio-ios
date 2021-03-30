//
//  APIResponseHandler+Extension.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import Foundation

struct ServiceError: Error,Codable {
    let httpStatus : Int
    let message: String
}

extension ResponseHandler{
    
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> [T]{
        let decoder = JSONDecoder()
        do {
            let body = try decoder.decode(Array<T>.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unkown error")
            }
        } catch  {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
    }
}
