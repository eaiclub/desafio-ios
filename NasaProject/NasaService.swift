//
//  NasaService.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 09/01/21.
//

import Foundation
import Alamofire

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

protocol NasaServiceProtocol {

}

extension Date {
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter
    }

    var description: String {
        dateFormatter.string(from: self)
    }
}

final class NasaService: NasaServiceProtocol {

    //in a real project we would move it to a plist and not push to the repository
    private let apiKey = "kZj8UK7DEsncdy0OTb64URlOSdFaDnCTx79h6Ceh"

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
