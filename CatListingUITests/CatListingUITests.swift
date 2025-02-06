import XCTest

final class CatAppUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false 
        app.launch()
    }


    func testListMainViewLoads() {
        let catList = app.navigationBars["Cats"]
        XCTAssertTrue(catList.waitForExistence(timeout: 5), "❌ 'Cats' list did not appear")

        let firstCatCell = app.cells.firstMatch
        XCTAssertTrue(firstCatCell.waitForExistence(timeout: 5), "❌ No cat cells found in the list")
    }


    func testInfiniteScrolling() {
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "❌ No initial cat cells found")

        let firstCount = app.cells.count
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        let newCount = app.cells.count
        print(newCount > firstCount)
        XCTAssert(newCount > firstCount)
    }


    func testNavigateToCatDetailView() {
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "❌ First cat cell not found")

        firstCell.tap() 

        let detailView = app.staticTexts["Cat Details"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5), "❌ Detail screen did not appear")
    }
}
