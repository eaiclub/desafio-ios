//
//  APOD.swift
//  NASA
//
//  Created by Matheus Pacheco Fusco on 12/02/21.
//  Copyright © 2021 Matheus Pacheco Fusco. All rights reserved.
//

import UIKit

struct APOD: Decodable {
    let date: String
    let explanation: String
    let hdUrl: String?
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdUrl = "hdurl"
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}
