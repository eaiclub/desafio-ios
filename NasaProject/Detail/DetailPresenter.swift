//
//  DetailPresenter.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 12/01/21.
//

import Foundation

final class DetailPresenter: Presenter {
    let body: CelestialBody

    var imageURL: String? {
        body.isVideo ? body.thumbnail : body.url
    }

    var title: String {
        "\(body.date) - \(body.title)"
    }

    init(body: CelestialBody) {
        self.body = body
    }
}
