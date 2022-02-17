//
//  APIRequest.swift
//  apod
//
//  Created by rafael.rollo on 24/09/21.
//

import Foundation
import Alamofire

fileprivate struct Endpoint {
    let path: String
    let queryParams: [URLQueryItem]
    
    private static let apiKey: String = "DEMO_KEY"
    
    var value: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = self.path
        components.queryItems = self.queryParams + [
            URLQueryItem(name: "api_key", value: Endpoint.apiKey)
        ]

        return components.url
    }
}

enum Resource {
    case apods(Date, Date)
    
    fileprivate func endpoint() -> URL? {
        switch self {
        case let .apods(startDate, endDate):
            let startDate = DateFormatter.format(to: .ISOLocalDate, value: startDate)
            let endDate = DateFormatter.format(to: .ISOLocalDate, value: endDate)
            
            let params = [
                URLQueryItem(name: "start_date", value: startDate),
                URLQueryItem(name: "end_date", value: endDate),
                URLQueryItem(name: "thumbs", value: String(true)),
            ]
            
            return Endpoint(
                path: "/planetary/apod",
                queryParams: params
            ).value
        }
    }
}

class APIRequest {
    
    ///
    /// Provide a simple API request interface as a service.
    /// Uses the Alamofire networking services wrapping the URLSession implementation details
    /// - returns: some decodable object
    ///
    static func execute<T: Decodable>(resource: Resource,
                                      httpMethod: HTTPMethod? = .get,
                                      body: Data? = nil,
                                      headers: HTTPHeaders? = nil,
                                      onCompletion: @escaping (T) -> Void,
                                      onFailure: @escaping (Error) -> Void) {
        
        guard let url = resource.endpoint() else {
            onFailure(NSError(domain: "Error creating URL", code: -11, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod?.rawValue
        request.httpBody = body
        
        if body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let headers = headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.name) }
        }
        
        request.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
        
        AF.request(request).validate(statusCode: 200..<300)
                .responseDecodable(of: T.self, decoder: CustomJSONDecoder()) { response in
            switch response.result {
            case .success(let value):
                onCompletion(value)

            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    private class CustomJSONDecoder: JSONDecoder {
        private lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()

        override init() {
            super.init()
            dateDecodingStrategy = .formatted(dateFormatter)
        }
    }
}
