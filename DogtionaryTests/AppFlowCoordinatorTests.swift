//
//  AppFlowCoordinatorTests.swift
//  DogtionaryTests
//
//  Created by myung hoon on 10/02/2024.
//

import XCTest
@testable import Dogtionary

final class AppFlowCoordinatorTests: XCTestCase {
    private lazy var flowCoordinator = AppFlowCoordinator(window: window, dependencyProvider: dependencyProvider)
    private let window =  UIWindow()
    private let dependencyProvider = MockAppFlowCoordinatorDependencyProvider()

    /// Test that application flow is started correctly
    func testStartsApplicationsFlow() {
        // GIVEN
        let rootViewController = UINavigationController()
        dependencyProvider.breedNavigationControllerTest = rootViewController

        // WHEN
        flowCoordinator.start()

        // THEN
        XCTAssertEqual(window.rootViewController, rootViewController)
    }
}
