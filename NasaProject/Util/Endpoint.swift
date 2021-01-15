//
//  Endpoint.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 10/01/21.
//

import Foundation

enum Endpoint {
    static let nasaUrl = "https://api.nasa.gov"

    case celestialBody

    var url: String {
        switch self {
        case .celestialBody:
            return "\(Endpoint.nasaUrl)/planetary/apod"
        }
    }
}
