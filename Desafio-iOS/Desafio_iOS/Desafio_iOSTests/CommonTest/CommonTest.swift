//
//  CommonTest.swift
//  Desafio_iOSTests
//
//  Created by Pedro Feitosa on 31/03/21.
//

import Foundation
@testable import Desafio_iOS
import XCTest

class CommonTest: XCTestCase {

    var stringTest = "1990-09-28"
    var dateTest = Date(timeIntervalSince1970: 10)
    var dayTrackerTest : DayTracker!
    
    override func setUp() {
        super.setUp()
        dayTrackerTest = DayTracker()
    }
    
    func testGetDateParameter(){
        XCTAssertNotNil(dayTrackerTest.getDateParamenter(statingDate: "2019-12-05", lowerBound: 5))
    }
    
    func testFormatStringToDate(){
        XCTAssertNotNil(stringTest.toDate())
    }
    
    func testGetFormattedDate(){
        XCTAssertNotNil(dateTest.getFormattedDate())
    }
    
    override func tearDown() {
        dayTrackerTest = nil
        super.tearDown()
    }
    

}
