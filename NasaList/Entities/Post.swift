//
//  Post.swift
//  NasaList
//
//  Created by Felipe Bastos on 19/11/20.
//

import Foundation

struct Post: Codable {
    
    let author: String?
    let date: String?
    let description: String?
    let image: String?
    let title: String?
    let imageHD: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "copyright"
        case date = "date"
        case description = "explanation"
        case image = "url"
        case title = "title"
        case imageHD = "hdurl"
        case type = "media_type"
    }
    
    init(author: String, date: String, description: String, image: String, title: String, imageHD: String, type: String?) {
        self.author = author
        self.date = date
        self.description = description
        self.image = image
        self.title = title
        self.imageHD = imageHD
        self.type = type
    }
}
