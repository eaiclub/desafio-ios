//
//  BaseService.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 12/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit
import Alamofire

typealias SuccessHandler  = ((_ anyObject: Any?) -> Void)?
typealias FailureHandler  = ((AFError?)-> Swift.Void)?

struct Constants {
    struct Api {
        static let baseUrl = "https://api.nasa.gov/"
    }
    
    struct Header {
        static let defaultHeaders: HTTPHeaders = ["Content-Type": "application/json",
                                                  "Accept": "*/*",
                                                  "Accept-Encoding": "gzip, deflate, br"]
    }
    
    struct Params {
        static let defaultParams: Dictionary<String, String> = ["api_key": "5sP0bLl5tyNHsiMW4XEHC3YhRfRhVQvawdZQgW9T"]
    }
}

class BaseService<T: Decodable>: NSObject {

    private func httpCall(url: String, method: HTTPMethod, headers: HTTPHeaders? = Constants.Header.defaultHeaders, params: Dictionary<String, String>? = Constants.Params.defaultParams, success: SuccessHandler, failure: FailureHandler) {
        guard let _url = URL(string: url) else {
            failure?(AFError.explicitlyCancelled)
            return
        }

        AF.request(_url,
                   method: method,
                   parameters: params,
                   headers: headers)
            .responseDecodable(of: T.self, completionHandler: { (response) in
                switch response.result {
                    case let .success(result):
                        success?(result)
                    case let .failure(error):
                        failure?(error)
                }
        })
    }
    
    public func get(url: String, headers: HTTPHeaders? = Constants.Header.defaultHeaders, params: Dictionary<String, String>? = Constants.Params.defaultParams, success: SuccessHandler, failure: FailureHandler) {
        self.httpCall(url: url,
                      method: .get,
                      headers: headers,
                      params: params,
                      success: success,
                      failure: failure)
    }
}
