//
//  APIHandler.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import Foundation

/// Enum representando os Http Methods
public enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

/// Enum representando os parâmtros default da API
public enum APIKeys: String{
    case API_KEY = "api_key"
    case API_VALUE = "DEMO_KEY"
    case DATE_START_KEY = "start_date"
    case DATE_END_KEY = "end_date"
}

/// Protocolo responsável pela implementação do corpo da URLRequest.
protocol RequestHandler {
    associatedtype RequestDataType
    /// Método genérico de se fazer a requisição
    /// - Parameter data: Tipo genérico de parâmetro a ser implementado.
    func makeRequest(from data: RequestDataType) -> URLRequest?
}

/// Protocolo responsável pela implementação do parse da response.
protocol ResponseHandler {
    associatedtype ResponseDataType
    /// Método generico de fazer o parse de dados.
    /// - Parameters:
    ///   - data: Qualquer data.
    ///   - response: Tipo genérico de retorno.
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> [ResponseDataType]?
}

typealias APIHandler = RequestHandler & ResponseHandler
