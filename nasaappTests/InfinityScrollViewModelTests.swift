import XCTest

@testable import nasaapp

class InfinityScrollViewModelTests: XCTestCase {
    
    var viewModel: InfinityScrollViewModel!

    override func setUp() {
        super.setUp()
        
        let nasaService = NasaService()
        let nasaRepository = NasaRepository(with: nasaService)
        viewModel = InfinityScrollViewModel(repository: nasaRepository, service: nasaService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfRows() throws {
        XCTAssertEqual(viewModel.getNumberOfRows(), viewModel.items.count+1)
    }
    
    func testConvertDateToString() throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "1992/10/26")
        
        guard let date = someDateTime else {
            return
        }
        
        let stringDate = viewModel.convertDateToString(date: date)
        
        XCTAssertEqual(stringDate, "1992-10-26")
    }
    
}
