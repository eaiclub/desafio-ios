//
//  HomeWorker.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

typealias HomeWorkerHandler = ([PlanetariumModel]) -> Swift.Void
typealias HomeWorkerFailure  = (NSError)-> Swift.Void

protocol HomeWorkerProtocol {
    func fetchPlanetarium(completion : @escaping HomeWorkerHandler, failure : @escaping HomeWorkerFailure)
}
 
class HomeWorker: HomeWorkerProtocol {

    func fetchPlanetarium(completion : @escaping HomeWorkerHandler, failure : @escaping HomeWorkerFailure) {
        let requestable = HomeWorkerRequestable(request: HomeModels.Planetarium.Request())
        let request: HTTRequest<[PlanetariumModel]> = HTTRequest(requestable: requestable)
        request.get(success: { response in
            guard let planetarium = response else {
                failure(NSError.generic)
                return
            }
            completion(planetarium)
        }, failure: { error in
            failure(NSError.generic)
        })
    }
}
