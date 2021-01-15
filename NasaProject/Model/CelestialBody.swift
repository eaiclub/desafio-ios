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
    let mediaType: String
    let thumbnail: String?

    var isVideo: Bool {
        mediaType == "video"
    }

    enum CodingKeys: String, CodingKey {
        case title, url, explanation, date
        case mediaType = "media_type"
        case thumbnail = "thumbnail_url"
    }

    // just used for mock purpose
    init(date: Date) {
        self.date = date.description
        self.title = "title"
        self.explanation = "explanation"
        self.url = "url.com"
        self.mediaType = "photo"
        self.thumbnail = nil
    }
}
