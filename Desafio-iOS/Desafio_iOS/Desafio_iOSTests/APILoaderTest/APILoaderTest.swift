//
//  APILoaderTest.swift
//  Desafio_iOSTests
//
//  Created by Pedro Feitosa on 31/03/21.
//

import Foundation

@testable import Desafio_iOS
import XCTest

class APILoaderTest: XCTestCase {

    
    var apiLoader : APILoader<NasaAPI>!
    
    override func setUp() {
        super.setUp()
        apiLoader = APILoader(apiRequest: NasaAPI())
    }
    
    
    func testloadAPIRequest(){
        
        let expectation = XCTestExpectation()
        let delay: TimeInterval = 10
        
        let queryParameters : KeyValuePairs<Any,Any> = [
            APIKeys.API_KEY.rawValue: APIKeys.API_VALUE.rawValue,
            APIKeys.DATE_START_KEY.rawValue : "2000-09-02",
            APIKeys.DATE_END_KEY.rawValue : "2000-09-03"
        ]

        apiLoader.loadAPIRequest(requestData: queryParameters) { (resultTest, errorTest) in
            
            XCTAssertNotNil(resultTest)
            expectation.fulfill()

        }
        
        
        wait(for: [expectation], timeout: delay)
        
    }
    
    override func tearDown() {
        apiLoader = nil
        super.tearDown()
    }
    

}
