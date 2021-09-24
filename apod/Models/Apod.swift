//
//  Apod.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import Foundation

enum MediaType: String, Decodable {
    case image
    case video
}

struct Apod: Decodable {
    var date: Date
    var author: String
    var mediaType: MediaType
    var title: String
    var explanation: String
    var resourcePath: URL
    var hdResourcePath: URL
        
    enum CodingKeys: String, CodingKey {
        case date
        case author = "copyright"
        case mediaType = "media_type"
        case title
        case explanation
        case resourcePath = "url"
        case hdResourcePath = "hdurl"
    }
}
