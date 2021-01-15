//
//  NasaProjectTests.swift
//  NasaProjectTests
//
//  Created by Gabriel Mocelin on 08/01/21.
//

import XCTest
@testable import NasaProject

class NasaProjectTests: XCTestCase {

    var feedPresenter: FeedPresenter!
    let date = DateFormatter.current.date(from: "2021-01-10")!

    override func setUpWithError() throws {
        feedPresenter = FeedPresenter(nasaService: NasaServiceMock(), currentDate: date)
    }

    func testFetchBodies() throws {
        feedPresenter.fetchBodies()

        XCTAssertEqual(feedPresenter?.numberOfItems(), 5)
    }

    func testPaginationShouldFetchMoreItems() throws {
        feedPresenter.fetchBodies()

        XCTAssertEqual(feedPresenter.numberOfItems(), 5)

        feedPresenter.checkPagination(for: IndexPath(row: 0, section: 0))

        XCTAssertEqual(feedPresenter.numberOfItems(), 10)
    }

    func testPaginationShouldNotFetchMoreItems() throws {
        feedPresenter.fetchBodies()

        XCTAssertEqual(feedPresenter.numberOfItems(), 5)

        feedPresenter.checkPagination(for: IndexPath(row: 1, section: 0))

        XCTAssertEqual(feedPresenter.numberOfItems(), 5)
    }

    func testGetDetailPresenter() throws {

        feedPresenter.fetchBodies()

        let index = IndexPath(row: 0, section: 0)
        let body = feedPresenter.item(for: 0)

        let detailPresenter = feedPresenter.getDetailPresenter(for: index)
        XCTAssertEqual(detailPresenter.body.date, body.date)
    }
}
