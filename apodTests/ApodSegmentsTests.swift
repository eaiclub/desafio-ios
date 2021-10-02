//
//  ApodSegmentsTests.swift
//  apodTests
//
//  Created by rafael.rollo on 01/10/21.
//

import XCTest

@testable import apod

class ApodSegmentsTests: XCTestCase {

    var sut: ApodSegments!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ApodSegments()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testThatDateRangeForCurrentDateCorrespondsToCurrentWeekDates() {
        let dates = try! sut.nextChunk()
        
        XCTAssertEqual(dates.count, 7, "Date range has not enough dates")
        
        XCTAssertEqual(dates.first!.timeIntervalSinceReferenceDate,
                       Date().timeIntervalSinceReferenceDate,
                       accuracy: 0.01,
                       "First date for the range is wrong.")
        
        let expectedLastDate = Calendar.current.date(byAdding: .day, value: -6, to: .init())!
        XCTAssertEqual(dates.last!.timeIntervalSinceReferenceDate,
                       expectedLastDate.timeIntervalSinceReferenceDate,
                       accuracy: 0.01,
                       "Last date for the range is wrong.")
    }
    
    func testThatTheSecondRangeForCurrentDateCorrespondsToPastWeekDates() {
        // consumes the first segment
        let _ = try! sut.nextChunk()
        
        let dates = try! sut.nextChunk()
        
        XCTAssertEqual(dates.count, 7, "Date range has not enough dates")
        
        let aWeekAgo: Date = Calendar.current
            .date(byAdding: .day, value: -7, to: .init())!
        
        XCTAssertEqual(dates.first!.timeIntervalSinceReferenceDate,
                       aWeekAgo.timeIntervalSinceReferenceDate,
                       accuracy: 0.01,
                       "First date for the range is wrong.")
        
        let firstPastWeekDay = Calendar.current
            .date(byAdding: .day, value: -6, to: aWeekAgo)!
        XCTAssertEqual(dates.last!.timeIntervalSinceReferenceDate,
                       firstPastWeekDay.timeIntervalSinceReferenceDate,
                       accuracy: 0.01,
                       "Last date for the range is wrong.")
    }
    
    func testThatIsNotPossibleToGetDateOlderThanTheLastKnownOne() {
        let fakeCurrentDate = DateFormatter.date(from: "1995-06-22",
                                                 using: .ISOLocalDate)
        sut = ApodSegments.init(with: fakeCurrentDate)
        XCTAssertEqual(sut.totalApods, 7, "Total count is wrong")
        
        // consumes the only available page
        let _ = try! sut.nextChunk()
        
        XCTAssertThrowsError(try sut.nextChunk(), "Inexistent next chunk") { error in
            print(error.localizedDescription)
        }
    }
    
    func testThatTheCalculationSucceedsForIncompletePagesSegments() {
        let fakeCurrentDate = DateFormatter.date(from: "1995-06-25",
                                                 using: .ISOLocalDate)
        sut = ApodSegments.init(with: fakeCurrentDate)
        XCTAssertEqual(sut.totalApods, 10, "Total count is wrong")
        
        // consumes the first available page
        let firstChunk = try! sut.nextChunk()
        XCTAssertEqual(firstChunk.count, 7, "First segment is wrong")
        
        // consumes the second available page
        let secondChunk = try! sut.nextChunk()
        XCTAssertEqual(secondChunk.count, 3, "Second segment is wrong")
        
        XCTAssertThrowsError(try sut.nextChunk(), "Inexistent next chunk") { error in
            print(error.localizedDescription)
        }
    }
    
    func testThatTheCalculationSucceedsForSingleIncompletePageSegment() {
        let fakeCurrentDate = DateFormatter.date(from: "1995-06-20",
                                                 using: .ISOLocalDate)
        sut = ApodSegments.init(with: fakeCurrentDate)
        XCTAssertEqual(sut.totalApods, 5, "Total count is wrong")
        
        // consumes the first available page
        let firstChunk = try! sut.nextChunk()
        XCTAssertEqual(firstChunk.count, 5, "First segment is wrong")
        
        XCTAssertThrowsError(try sut.nextChunk(), "Inexistent next chunk") { error in
            print(error.localizedDescription)
        }
    }
}
