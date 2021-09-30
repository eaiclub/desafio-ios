//
//  NaoSei.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import Foundation

class ApodSegments {
    
    private var currentDate: Date
    private let oldestValidDate: Date = DateFormatter.date(from: "1995-06-16",
                                                           using: .ISOLocalDate)
        
    private let segmentSize: Int = 7
    private(set) var totalApods: Int
    private(set) var currentPage: Int = 0
    
    init() {
        self.currentDate = .init()
        self.totalApods = Calendar.current
            .numberOfDaysBetween(oldestValidDate, and: self.currentDate)
    }
    
    private func segment(for page: Int) -> [Date] {
        let maxPage = totalApods / segmentSize + 1
        precondition(page > 0 && page < maxPage , "Invalid page for segment generator")
        
        let dateDecrement = segmentSize * (page - 1)
            
        let pageFirstDate = Calendar.current.date(byAdding: .day,
                                                  value: -dateDecrement,
                                                  to: currentDate)
        
        guard let pageFirstDate = pageFirstDate else {
            fatalError("Could not possible to calculate dates")
        }
        
        var segment = [pageFirstDate]
        for i in 1..<segmentSize {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: pageFirstDate)!
            segment.append(date)
        }
        
        return segment
    }
    
    func nextChunk() -> [Date] {
        currentPage += 1
        return segment(for: currentPage)
    }
    
    func reset() {
        currentPage = 0
    }
}
