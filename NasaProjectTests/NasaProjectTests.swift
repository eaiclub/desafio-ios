//
//  NasaProjectTests.swift
//  NasaProjectTests
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import XCTest
@testable import NasaProject

class NasaProjectTests: XCTestCase {

    var feedPresenter: FeedPresenter?
    let date = DateFormatter.current.date(from: "2021-01-10")!

    override func setUpWithError() throws {
        feedPresenter = FeedPresenter(nasaService: NasaServiceMock(), currentDate: date)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
