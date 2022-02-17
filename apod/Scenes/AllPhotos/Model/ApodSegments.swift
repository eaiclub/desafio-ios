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
        
    private let pageSize: Int = 7
    private let fullPages: Int
    private var itemsOnIncompleteLastPage: Int? = nil
    private var maxPage: Int
    
    private(set) var totalApods: Int
    private(set) var currentPage: Int = 0
    
    init(with date: Date = .init()) {
        self.currentDate = date
        self.totalApods = Calendar.current
            .numberOfDaysBetween(oldestValidDate, and: self.currentDate)
        
        self.fullPages = totalApods / pageSize
        self.maxPage = fullPages
        
        let totalModSize = totalApods % pageSize
        
        if totalModSize != 0 {
            self.itemsOnIncompleteLastPage = totalModSize
            self.maxPage = fullPages + 1
        }
    }
        
    private func segment(for page: Int) throws -> [Date] {
        let isValidPage = page > 0 && page <= maxPage
        
        if !isValidPage {
            throw SegmentError.invalidPage("Could not possible to calcule dates segment")
        }
        
        let dateDecrement = -(pageSize * (page - 1))
        let pageFirstDate = Calendar.current.date(byAdding: .day,
                                                  value: dateDecrement,
                                                  to: currentDate)
        
        guard let pageFirstDate = pageFirstDate else {
            fatalError("Could not possible to calculate dates")
        }
        
        var itemsInSegment = pageSize
        
        if page == maxPage,
           let itemsOnIncompleteLastPage = itemsOnIncompleteLastPage {
            itemsInSegment = itemsOnIncompleteLastPage
        }
        
        var segment = [pageFirstDate]
        for i in 1..<(itemsInSegment) {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: pageFirstDate)!
            segment.append(date)
        }
        
        return segment
    }
    
    func nextChunk() throws -> [Date] {
        currentPage += 1
        return try segment(for: currentPage)
    }
    
    func reset() {
        currentPage = 0
    }
}

extension ApodSegments {
    enum SegmentError: Error {
        case invalidPage(String)
    }
}
