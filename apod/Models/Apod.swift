//
//  Apod.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import Foundation

struct Apod: Codable {
    
    enum MediaType: String, Codable {
        case image
        case video
        
        static func resourceLocation(for apod: Apod) -> URL? {
            switch apod.mediaType {
            case .video:
                guard let thumbPath = apod.thumbnailPath else { return nil }
                return URL(string: thumbPath)
            default:
                return URL(string: apod.resourcePath)
            }
        }
    }
    
    var date: Date
    var author: String?
    var mediaType: MediaType
    var title: String
    var explanation: String
    var resourcePath: String
    var hdResourcePath: String?
    var thumbnailPath: String?
        
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
