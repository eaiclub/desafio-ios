//
//  FeedPresenter.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import Foundation

final class FeedPresenter: Presenter {
    init() {
        NasaService().fetchCelestialBody(for: Date()) { result in
            switch result {
            case .success(let body):
                print(body)
            case .failure(let error):
                print(error)
            }
        }
    }
}
