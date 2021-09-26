//
//  Apod.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import Foundation

enum MediaType: String, Codable {
    case image
    case video
}

struct Apod: Codable {
    var date: Date
    var author: String?
    var mediaType: MediaType
    var title: String
    var explanation: String
    var resourcePath: URL
    var hdResourcePath: URL?
    var thumbnailPath: URL?
        
    enum CodingKeys: String, CodingKey {
        case date
        case author = "copyright"
        case mediaType = "media_type"
        case title
        case explanation
        case resourcePath = "url"
        case hdResourcePath = "hdurl"
        case thumbnailPath = "thumbnail_url"
    }
}
