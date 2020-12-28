//
//  RequestBase.swift
//  PernambucanasVarejo
//
//  Created by Rhullian Damião on 14/11/20.
//  Copyright © 2020 Rodrigo. All rights reserved.
//

import Alamofire

enum RequestMethods {
  case get
  case post
  case delete
  case put
  
  var rawValue: HTTPMethod {
    switch self {
    case .delete: return .delete
    case .post: return .post
    case .get: return .get
    case .put: return .put
    }
  }
}

protocol RequestBase {
  var path: String { get }
  var method: RequestMethods { get }
  var header: [String: Any]? { get }
  var params: Codable? { get }
  var baseUrl: String { get }
  func makeRequest<T: Codable>(success: ((T) -> Void)?, failure: ((String)-> Void)?)
}

extension RequestBase {
  func makeRequest<T: Codable>(success: ((T) -> Void)? = nil, failure: ((String)-> Void)? = nil) {
    print("\n\n----MAKING REQUEST: \(baseUrl+path) - \(method.rawValue)\n")
    print("With parameters: \(params.debugDescription)")
    AF.request(baseUrl+path, method: method.rawValue, parameters: params?.asDictionary(), encoding: JSONEncoding.default)
      .validate()
      .responseJSON { (response) in
        print(">> REQUEST: \(response.request?.urlRequest?.description ?? "INVALID") \n\n \n\n RESPONSE:\n \(String(data: response.data ?? Data(), encoding: .utf8))\n\n\n")
        if let error = response.error {
          print("!!!!!ERROR: " + error.localizedDescription)
          failure?(error.localizedDescription)
          return
        }
        guard let data = response.data,
              let object = try? JSONDecoder().decode(T.self, from: data) else {
          print("\n\n\n ----FAIL IN PARSE!")
          failure?("----FAIL IN PARSE!")
          return
        }
        print("\n\n\n ----SUCCESS IN REQUEST!")
        success?(object)
      }
  }
}
