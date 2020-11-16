import XCTest
@testable import nasaapp

class NasaResponseItemModelTests: XCTestCase {
    
    func testImageResponse() throws {
        let decoder = JSONDecoder()
        let data = "image".jsonData
        let item = try decoder.decode(NasaResponseItem.self, from: data)
        XCTAssertEqual(item.title, "Edge-On Galaxy NGC 5866")
        XCTAssertEqual(item.media_type, "image")
    }
    
    func testVideoResponse() throws {
        let decoder = JSONDecoder()
        let data = "video".jsonData
        let item = try decoder.decode(NasaResponseItem.self, from: data)
        XCTAssertEqual(item.title, "Tagging Bennu: The Movie")
        XCTAssertEqual(item.media_type, "video")
    }
}
