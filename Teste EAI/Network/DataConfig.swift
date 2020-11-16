//
//  DataConfig.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 12/11/20.
//

import Moya

public enum NetworkError: Error {
    case badURL
    case badJSONFormat
    case unknownError
    case userNotLogged
}

struct DataConfig {
    static public let xchannel = "ios"
        
    static public func getEntryPoint() -> URL {
        switch NetworkConfig.shared.environment {
        case .develop?:
            return URL(string: "https://demo2809429.mockable.io")!
        case .qa:
            return URL(string: "https://api.nasa.gov/planetary")!
        case .prod?:
            return URL(string: "https://api.nasa.gov/planetary")!
        case .none:
            return URL(string: "https://api.nasa.gov/planetary")!
        }
    }
        
    static public func getAPIKey() -> String {
        // used for testing
        return "DEMO_KEY"
    }
}
