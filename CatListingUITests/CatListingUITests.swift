//
//  CatListingUITests.swift
//  CatListingUITests
//
//  Created by LUIS FELIPE B PEREIRA on 06/02/25.
//

import XCTest

final class CatListingUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testCatListViewAppears() throws {
        let catList = app.navigationBars["Cats"]
        
        XCTAssertTrue(catList.exists, "❌ 'Cat' title not found")
    }
    
    func testNavigateToCatDetailView() {
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "❌ First cat cell does not exist")

        firstCell.tap()

        let detailView = app.staticTexts["Origin:"]
        XCTAssertTrue(detailView.exists, "❌ Detail screen did not appear")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
