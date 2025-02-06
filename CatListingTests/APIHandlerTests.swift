import XCTest
@testable import CatListing

class APIHandlerTests: XCTestCase {
    var apiHandler: APIHandler!

    override func setUp() {
        super.setUp()
        apiHandler = APIHandler(apiKey: Constants.key.rawValue, baseURL: Constants.baseURL.rawValue)
    }

    override func tearDown() {
        apiHandler = nil
        super.tearDown()
    }

    func testFetchCats_Success() {
        let expectation = XCTestExpectation(description: "Fetch Cats API Call")

        apiHandler.fetchCats(page: 1) { result in
            switch result {
            case .success(let cats):
                XCTAssertFalse(cats.isEmpty, "Cats list should not be empty")
                expectation.fulfill()

            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }

        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchCats_Fail() {
        let expectation = XCTestExpectation(description: "Fetch Cats API Call Fails")
        apiHandler.changeURL(baseURL: "")
        apiHandler.fetchCats(page: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected Fail, but got success")
                
            case .failure(let error):
                print(error)
                XCTAssert(error == .requestFailed)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5) 
    }

}
