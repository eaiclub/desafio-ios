//
//  NasaImageParametersModel.swift
//  EAIClub-Challenge
//
//  Created by Rhullian Damião on 27/12/20.
//

import Foundation
struct NasaImageParametersModel: Codable {
  var date: String?
  var hd: Bool?
  private let api_key: String = "DEMO_KEY"
}
