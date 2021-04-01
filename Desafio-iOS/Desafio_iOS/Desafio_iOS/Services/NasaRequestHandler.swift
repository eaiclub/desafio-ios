//
//  NasaRequestHandler.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 01/04/21.
//

import Foundation


/// Classe especialista de requisição.
class NasaRequestHandler{
    
    
    /// Variável que guarda a referência da nasaAPI
    let request = NasaAPI()
    
    /// Método responsável por fazer a requisição dos dados.
    /// - Parameters:
    ///   - dates: Range de datas para se fazer a pesquisa.
    ///   - completionHandler: Callback com as url das imagens e possíveis erros.
    /// - Returns: Closure.
    func fetchNasaData(with dates: [String], completionHandler: @escaping ([String]?, Error?) -> ()){
        let apiLoader = APILoader(apiRequest: request)
        var arrayData : [String] = []
        let queryParameters : KeyValuePairs<Any,Any> = [
            APIKeys.API_KEY.rawValue: APIKeys.API_VALUE.rawValue,
            APIKeys.DATE_START_KEY.rawValue : dates.first!,
            APIKeys.DATE_END_KEY.rawValue : dates.last!
        ]
        
        apiLoader.loadAPIRequest(requestData: queryParameters) { (model, error) in
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    
                    model?.forEach({ (url) in
                        if url.url.contains("youtube"){
                            return
                        } else {
                        arrayData.append(url.url)
                        }
                    })
                    
                    completionHandler(arrayData, nil)

                }
            }
        
        
        
    }
    
    
}
