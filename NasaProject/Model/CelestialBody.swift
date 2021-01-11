//
//  CelestialBody.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 09/01/21.
//

import Foundation

struct CelestialBody: Codable {
    let title: String
    let url: String
    let explanation: String
    let date: String
    let media_type: String

    var isVideo: Bool {
        media_type == "video"
    }
}
