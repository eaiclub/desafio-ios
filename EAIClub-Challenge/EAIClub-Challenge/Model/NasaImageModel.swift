//
//  NasaImageModel.swift
//  EAIClub-Challenge
//
//  Created by Rhullian Damião on 27/12/20.
//

import Foundation
import Alamofire

// MARK: - NasaImageModel
struct NasaImageModel: Codable {
    var copyright, date, explanation: String?
    var hdurl: String?
    var mediaType, serviceVersion, title: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
