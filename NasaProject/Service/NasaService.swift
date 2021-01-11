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
        let group = DispatchGroup()

        var bodies: [CelestialBody] = []

        dates.forEach {
            group.enter()
            fetchCelestialBody(for: $0) { result in
                switch result {
                case .success(let body):
                    bodies.append(body)
                case .failure(let error):
                    print(error)
                }

                group.leave()
            }
        }

        group.notify(queue: .main) {
            bodies.isEmpty ? completion(.failure(CustomError.fetchBodiesError)) : completion(.success(bodies))
        }
    }

    func fetchCelestialBody(for date: Date, completion: @escaping (Result<CelestialBody, Error>) -> Void) {
        let url = Endpoint.celestialBody.url

        let parameters = ["api_key": apiKey, "date": date.description]

        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: CelestialBody.self) { response in
            switch response.result {
            case .success(let body):
                completion(.success(body))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}