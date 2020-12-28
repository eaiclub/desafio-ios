//
//  JSONManager.swift
//  EAIClub-Challenge
//
//  Created by Rhullian Damião on 27/12/20.
//

import Foundation

extension Encodable {
  func asDictionary() -> [String: Any]? {
    guard let encodedData = try? JSONEncoder().encode(self) else { return nil }
    return try? JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String: Any]
  }
}
