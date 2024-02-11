//
//  BreedListViewUITests.swift
//  BreedListViewUITests
//
//  Created by myung hoon on 06/02/2024.
//

import XCTest

final class BreedListViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    private func waitForTableViewToLoad() throws {
        let tableView = app.tables[AccessibilityIdentifiers.BreedList.tableViewViewId]
        let cells = tableView.cells
        
        sleep(5)
        XCTAssertTrue(cells.count > 0, "BreedList tableView's cells have not been loaded!")
    }
    
    func testNavigationTitle() throws {
        let navBar = app.navigationBars.element
        XCTAssert(navBar.exists)
        
        let title = "Dogtionary"
        let navBarTitle = app.staticTexts[title]
        
        XCTAssert(navBarTitle.exists, "The navigationBar title should be \(title)")
    }
    
    func testCollectionViewRowCellCount() throws {
        // GIVEN
        try? waitForTableViewToLoad()
        
        let tableView = app.tables[AccessibilityIdentifiers.BreedList.tableViewViewId]
        let cells = tableView.cells
        let expectedItemsPerRow = 1
        
        // THEN
        XCTAssertEqual(cells.count % expectedItemsPerRow, 0, "The number of cells in each row should be \(expectedItemsPerRow)")
    }
    
    func testSearchTextFieldTappedKeyboardAppear() throws {
        // GIVEN
        try? waitForTableViewToLoad()
        
        let searchTextField = app.searchFields[AccessibilityIdentifiers.BreedList.searchTextFieldId]
        
        // WHEN
        searchTextField.tap()
        
        // THEN
        XCTAssertTrue(searchTextField.exists, "Search text field is not visible.")
        XCTAssertTrue(app.keyboards.count > 0, "Keyboard is not visible.")
    }
    
    func testFirstCellAfterSearching() {
        // GIVEN
        try? waitForTableViewToLoad()
        
        let tableView = app.tables[AccessibilityIdentifiers.BreedList.tableViewViewId]
        let searchTextField = app.searchFields[AccessibilityIdentifiers.BreedList.searchTextFieldId]
        
        // WHEN
        // Search bar is hidden when it is laid landscape due to narrower size, so force rotating it for testing.
        if !UIDevice.current.orientation.isPortrait {
            XCUIDevice.shared.orientation = .portrait
            sleep(2)
        }
        
        tableView.swipeDown()
        searchTextField.tap()
        searchTextField.typeText("bulldog")
        
        sleep(2)
        
        // THEN
        let firstCell = tableView.cells.firstMatch
        XCTAssertTrue(firstCell.exists)
        XCTAssertTrue(firstCell.staticTexts["Bulldog"].exists)
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
