//
//  PlanetariumModel.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 11/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import Foundation

struct PlanetariumModel: Codable, Equatable {
    var date            : String?
    var explanation     : String?
    var hdurl           : String?
    var mediaType       : String?
    var serviceVersion  : String?
    var title           : String?
    var url             : String?
    
    private enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl, title, url
        case mediaType      = "media_type"
        case serviceVersion = "service_version"
    }
    
    init(date: String, explanation: String, hdurl: String, mediaType: String, serviceVersion: String, title: String, url: String) {
        self.date        = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
        self.title       = title
        self.url         = url
    }
}
