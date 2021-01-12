//
//  DateExtension.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 10/01/21.
//

import Foundation

extension DateFormatter {
    static var current: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}

extension Date {
    var description: String {
        DateFormatter.current.string(from: self)
    }
}
