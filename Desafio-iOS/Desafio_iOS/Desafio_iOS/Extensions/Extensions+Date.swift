//
//  Extensions+Date.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation

extension Date {
    
    /// Método para formatar a data em string
    /// - Returns: String da data.
   func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: self)
    }
}
