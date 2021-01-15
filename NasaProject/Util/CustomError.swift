//
//  CustomError.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 10/01/21.
//

import Foundation

enum CustomError: Error {
    case fetchBodiesError

    var description: String {
        switch self {
        case .fetchBodiesError:
            return "Failed to fetch Celestial Bodies"
        }
    }
}
