//
//  APIHandler.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import Foundation

public enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public enum APIKeys: String{
    case API_KEY = "api_key"
    case API_VALUE = "DEMO_KEY"
    case DATE_START_KEY = "start_date"
    case DATE_END_KEY = "end_date"
}

protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data: RequestDataType) -> URLRequest?
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [ResponseDataType]?
}

typealias APIHandler = RequestHandler & ResponseHandler
