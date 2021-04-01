//
//  APIRequestHandler+Extensions.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import Foundation

extension RequestHandler{
    
    /// Método responsável por adicionar os parâmetros na query.
    /// - Parameters:
    ///   - parameters: Parâmetros a ser adicionado na URL.
    ///   - url: URL base.
    /// - Returns: URL com parâmetros adicionados.
    func setQueryParams(parameters:KeyValuePairs<Any, Any>, url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key as! String, value: String(describing: element.value) ) }
        
        return components?.url ?? url
    }
    
}
