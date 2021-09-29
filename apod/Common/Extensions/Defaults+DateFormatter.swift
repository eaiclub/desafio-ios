//
//  Defaults+DateFormatter.swift
//  apod
//
//  Created by rafael.rollo on 24/09/21.
//

import Foundation

extension DateFormatter {
    enum FormatDefaults: String {
        case abbreviatedMonthOfYear = "MMM yyyy"
        case ISOLocalDate = "yyyy-MM-dd"
        case monthDayYear = "MM/dd/yyyy"
    }
    
    static func format(to pattern: FormatDefaults, value: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern.rawValue
        
        return formatter.string(from: value)
    }
    
    static func date(from string: String, using pattern: FormatDefaults) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern.rawValue
        
        return formatter.date(from: string)!
    }
}
