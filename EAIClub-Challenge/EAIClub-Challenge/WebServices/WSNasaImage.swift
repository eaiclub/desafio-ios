//
//  WSNasaImage.swift
//  EAIClub-Challenge
//
//  Created by Rhullian Damião on 27/12/20.
//

import Foundation

class WSNasaMedia {
  enum Endpoints: RequestBase {
    case getSpaceImage
    var path: String {
      switch self {
      case .getSpaceImage: return ""
      }
    }
    
    var method: RequestMethods {
      switch self {
      case .getSpaceImage: return .get
      }
    }
    
    var header: [String: Any]? {
      switch self {
      case .getSpaceImage: return nil
      }
    }
    
    var params: Codable? {
      switch self {
      case .getSpaceImage: return nil
      }
    }
    
    var baseUrl: String {
      switch self {
      case .getSpaceImage: return "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&hd=true&date=2020-12-25"
      }
    }
  }
}
