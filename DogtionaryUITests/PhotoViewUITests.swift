//
//  PhotoViewUITests.swift
//  DogtionaryUITests
//
//  Created by myung hoon on 11/02/2024.
//

import XCTest

final class PhotoViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    private func waitForPhotoViewToLoad() throws {
        let tableView = app.tables[AccessibilityIdentifiers.BreedList.tableViewViewId]
        tableView.cells.firstMatch.tap()
        
        let collectionView = app.collectionViews[AccessibilityIdentifiers.BreedDetail.collectionViewId]
        collectionView.cells.firstMatch.tap()
        
        let photoView = app.otherElements[AccessibilityIdentifiers.PhotoView.rootViewId]
        
        XCTAssert(photoView.exists, "PhotoView has not been loaded!")
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testCloseButton() throws {
        try? waitForPhotoViewToLoad()
        
        let closeButton = app.buttons[AccessibilityIdentifiers.PhotoView.closeButtonId]
        closeButton.tap()
        XCTAssert(!closeButton.waitForExistence(timeout: 0.5))
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
