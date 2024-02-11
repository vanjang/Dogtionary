//
//  BreedDetailViewUITests.swift
//  DogtionaryUITests
//
//  Created by myung hoon on 11/02/2024.
//

import XCTest
@testable import Dogtionary

final class BreedDetailViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    private func waitForCollectionViewToLoad() throws {
        let tableView = app.tables[AccessibilityIdentifiers.BreedList.tableViewViewId]
        tableView.cells.firstMatch.tap()
        
        let collectionView = app.collectionViews[AccessibilityIdentifiers.BreedDetail.collectionViewId]
        let cells = collectionView.cells
        
        XCTAssertTrue(cells.count > 0, "BreedList tableView's cells have not been loaded!")
    }
    
    func testCollectionViewRowCellCount() throws {
        // GIVEN
        try? waitForCollectionViewToLoad()
        
        let collectionView = app.collectionViews[AccessibilityIdentifiers.BreedDetail.collectionViewId]
        let cells = collectionView.cells
        let expectedItemsPerRow = 2
        
        // THEN
        XCTAssert(cells.count <= 10, "The number of cells should be equal or less than 10")
        XCTAssertEqual(cells.count % expectedItemsPerRow, 0, "The number of cells in each row should be \(expectedItemsPerRow)")
    }
    
    func testPhotoViewControllerShowing() throws {
        // GIVEN
        try? waitForCollectionViewToLoad()
     
        let collectionView = app.collectionViews[AccessibilityIdentifiers.BreedDetail.collectionViewId]
        let cells = collectionView.cells
        
        // WHEN
        cells.firstMatch.tap()
        
        // THEN
        XCTAssertTrue(app.otherElements[AccessibilityIdentifiers.PhotoView.rootViewId].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
