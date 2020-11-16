//
//  EAIAPI.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 12/11/20.
//

import Moya
import Result

public class EAIAPI {
    
    public init() {}
    
    let provider: MoyaProvider<EAITargetType> = MoyaProvider(plugins: [NetworkLoggerPlugin()])
        
    public func getPlanetary(dateSearch: String, fullHD: Bool, completionHandler: @escaping(Result<PlanetaryModelResponse, NetworkError>)->Void) {        
        self.provider.request(.planetary(dateSearch: dateSearch, fullHD: fullHD)) { result in
            switch result {
            case .success(let response):
                do {
                    let planetaryResponse = try response.map(PlanetaryModelResponse.self)
                    completionHandler(.success(planetaryResponse))
                } catch {
                    completionHandler(.failure(.badJSONFormat))
                }
            case .failure:
                completionHandler(.failure(.unknownError))
            }
        }
    }
            
}


