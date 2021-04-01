//
//  Extensions+String.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation

extension String {
    
    /// Método para transformar a string em data.
    /// - Parameter format: String para ser transformado em data.
    /// - Returns: Data.
    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
