//
//  NaoSei.swift
//  apod
//
//  Created by rafael.rollo on 23/09/21.
//

import Foundation

class PostsSegmentManager {
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    private let oldestValidDate: Date = dateFormatter
        .date(from: "20/06/1995")!
    
    private var currentDate: Date = .init()
    
    private(set) var totalApod: Int
    
    private let segmentSize: Int = 7
    
    private var currentPage: Int = 1
    
    init() {
        self.totalApod = Calendar.current
            .numberOfDaysBetween(oldestValidDate, and: currentDate)
    }
    
    private func segment(for page: Int) -> [Date] {
        let maxPage = totalApod / segmentSize + 1
        precondition(page > 0 && page < maxPage , "Invalid page for segment generator")
        
        let dateDecrement = segmentSize * (page - 1)
            
        let pageFirstDate = Calendar.current.date(byAdding: .day, value: -dateDecrement, to: currentDate)
        
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
    
    func nextChunk() -> [Post] {
        let posts = segment(for: currentPage)
            .map { Post(date: $0, apod: nil) }

        currentPage += 1
        return posts
    }
}
