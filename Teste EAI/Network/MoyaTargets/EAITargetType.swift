//
//  EAITargetType.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 12/11/20.
//

import Moya

public enum EAITargetType {
    case planetary(dateSearch: String, fullHD: Bool)
}

extension EAITargetType: TargetType {
    public var baseURL: URL {
        return DataConfig.getEntryPoint()
    }
    
    public var path: String {
        switch self {
        case .planetary:
            return "/apod"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .planetary: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .planetary(let dateSearch, let fullHD):
            return .requestParameters(parameters: ["api_key": DataConfig.getAPIKey(), "date": dateSearch, "hd": fullHD], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
        case .planetary:
            let rewardsParams = ["Content-Type":"application/json"]
            return rewardsParams
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
