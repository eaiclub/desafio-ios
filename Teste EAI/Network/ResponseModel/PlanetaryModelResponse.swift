//
//  PlanetaryModelResponse.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 12/11/20.
//

import Foundation

public enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
}

// MARK: - PlanetaryModel
public class PlanetaryModelResponse: Codable {
    public let copyright: String?
    public let date: String?
    public let explanation: String?
    public let hdurl: String?
    public let mediaType: MediaType?
    public let serviceVersion: String?
    public let title: String?
    public let url: String?

    enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case date = "date"
        case explanation = "explanation"
        case hdurl = "hdurl"
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title = "title"
        case url = "url"
    }

    public init(copyright: String?, date: String?, explanation: String?, hdurl: String?, mediaType: MediaType?, serviceVersion: String?, title: String?, url: String?) {
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
        self.title = title
        self.url = url
    }
}
