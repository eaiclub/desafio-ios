//
//  HomeWorkerTests.swift
//  NASATests
//
//  Created by Gustavo Rodrigues Leitão on 12/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import XCTest

@testable import NASA

class HomeWorkerTests: XCTestCase {
    
    func test_fetch_Planetarium_should_complete_with_error_if_requisition_completes_with_error() {
        let (sut, homeWorkerSpy) = homeWorkerSut()
        let exp = expectation(description: "waiting")
        sut.fetchPlanetarium(completion: {_ in}) { (error) in
            XCTAssertEqual(error, NSError.generic)
            exp.fulfill()
        }
        homeWorkerSpy.completeWithFailure(NSError.generic)
        wait(for: [exp], timeout: 5)
    }
    
    func test_fetch_Planetarium_should_complete_with_error_if_requisition_completes_with_data() {
        let (sut, homeWorkerSpy) = homeWorkerSut()
        let exp = expectation(description: "waiting")
        let expectedPlanetarium = makePlanetariumModel()
        sut.fetchPlanetarium(completion: { response in
            XCTAssertEqual(response, [expectedPlanetarium])
            exp.fulfill()
        }, failure: {_ in})
        homeWorkerSpy.completeWithData([expectedPlanetarium])
        wait(for: [exp], timeout: 20)
    }
}

extension HomeWorkerTests {
    
    func homeWorkerSut() -> (sut: HomeWorker, homeWorkerSpy: HomeWorkerSpy) {
        let sut = HomeWorker()
        let homeWorkerSpy = HomeWorkerSpy()
        return (sut, homeWorkerSpy)
    }
    
    class HomeWorkerSpy: HomeWorkerProtocol {
        private var completion: (([PlanetariumModel]) -> Swift.Void)?
        private var failure: ((NSError)-> Swift.Void)?
        
        func fetchPlanetarium(completion: @escaping HomeWorkerHandler, failure: @escaping HomeWorkerFailure) {
            self.failure = failure
        }
 
        func completeWithFailure(_ error: NSError) {
            self.failure?(error)
        }
        
        func completeWithData(_ data: [PlanetariumModel]) {
            self.completion?(data)
        }
    }
    
    func makePlanetariumModel() -> PlanetariumModel {
        return PlanetariumModel(date: "any_date", explanation: "any_description", hdurl: "any_hdurl", mediaType: "any_mediaType", serviceVersion: "any_serviceVersion", title: "any_title", url: "any_title")
    }
}
