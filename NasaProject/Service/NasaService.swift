//
//  NasaService.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 09/01/21.
//

import Foundation
import Alamofire

protocol NasaServiceProtocol {
    func fetchCelestialBodies(for dates: [Date], completion: @escaping (Result<[CelestialBody], Error>) -> Void)
}

final class NasaService: NasaServiceProtocol {

    //in a real project we would move it to a plist and not push to the repository
    private let apiKey = "kZj8UK7DEsncdy0OTb64URlOSdFaDnCTx79h6Ceh"

    func fetchCelestialBodies(for dates: [Date], completion: @escaping (Result<[CelestialBody], Error>) -> Void) {
        if let startDate = dates.first, let endDate = dates.last {
            fetchCelestialBodies(startDate: startDate, endDate: endDate, completion: completion)
        } else if let date = dates.first {
            fetchCelestialBody(for: date, completion: completion)
        } else {
            completion(.failure(CustomError.fetchBodiesError))
        }
    }

    private func fetchCelestialBodies(startDate: Date, endDate: Date, completion: @escaping (Result<[CelestialBody], Error>) -> Void) {
        let url = Endpoint.celestialBody.url

        let parameters: [String: Any] = [
            "api_key": apiKey,
            "start_date": startDate.description,
            "end_date": endDate.description,
            "thumbs": true
        ]

        fetch(url: url, parameters: parameters, completion: completion)
    }

    private func fetchCelestialBody(for date: Date, completion: @escaping (Result<[CelestialBody], Error>) -> Void) {
        let url = Endpoint.celestialBody.url

        let parameters: [String: Any] = ["api_key": apiKey, "date": date.description, "thumbs": true]

        fetch(url: url, parameters: parameters) { (response: Result<CelestialBody, Error>) in
            switch response {
            case .success(let body):
                completion(.success([body]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func fetch<T: Codable>(url: String, parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
