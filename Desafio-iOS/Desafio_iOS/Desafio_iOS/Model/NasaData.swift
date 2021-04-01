//
//  NasaData.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 29/03/21.
//

import Foundation

/// Model das informações a serem retiradas da API
struct NasaData: Codable {
    let title: String
    let url: String
}
