//
//  Post.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import Foundation

struct Post: Decodable {
    var date: Date
    var apod: Apod?
}
