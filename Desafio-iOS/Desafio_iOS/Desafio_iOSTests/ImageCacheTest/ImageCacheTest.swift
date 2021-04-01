//
//  ImageCacheTest.swift
//  Desafio_iOSTests
//
//  Created by Pedro Feitosa on 31/03/21.
//

@testable import Desafio_iOS
import XCTest

class ImageCacheTest: XCTestCase {
    
    var imageCacheTest : ImageCache!
    
    override func setUp() {
        super.setUp()
        
        self.imageCacheTest = ImageCache()
        
        
        
    }
    
    func testDownloadImage(){
        
        let delay : TimeInterval = 10
        let expectation = XCTestExpectation()
        let url = URL(string: "https://apod.nasa.gov/apod/image/0009/rosat_moon.jpg")!
        
        imageCacheTest.downloadImage(url: url) { (image) in
            
            XCTAssertNotNil(image)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: delay)
        
    }
    
    
    override func tearDown() {
        imageCacheTest = nil
        super.tearDown()
    }
    

}
