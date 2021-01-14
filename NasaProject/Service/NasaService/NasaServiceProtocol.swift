//
//  NasaServiceProtocol.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 14/01/21.
//

import Foundation

protocol NasaServiceProtocol {
    func fetchCelestialBodies(for dates: [Date], completion: @escaping (Result<[CelestialBody], Error>) -> Void)
}

//Mark: - Mock
final class NasaServiceMock: NasaServiceProtocol {
    func fetchCelestialBodies(for dates: [Date], completion: @escaping (Result<[CelestialBody], Error>) -> Void) {
        if dates.isEmpty {
            completion(.failure(CustomError.fetchBodiesError))
        }

        let bodies = dates.map { CelestialBody(date: $0) }
        completion(.success(bodies))
    }
}
