//
//  BreedCoordinatorTests.swift
//  DogtionaryTests
//
//  Created by myung hoon on 10/02/2024.
//

import XCTest
@testable import Dogtionary

final class BreedCoordinatorTests: XCTestCase {
    private lazy var flowCoordinator = BreedCoordinator(window: window, dependencyProvider: dependencyProvider)
    private let window =  UIWindow()
    private let dependencyProvider = MockBreedCoordinatorDependencyProvider()

    func startAppFlow() {
        let rootViewController = UINavigationController()
        dependencyProvider.breedNavigationControllerTest = rootViewController
        flowCoordinator.start()
    }
    
    func testPresentBreedDetailViewController() throws {
        // GIVEN
        startAppFlow()
        let detailViewController = UIViewController()
        dependencyProvider.breedDetailViewControllerTest = detailViewController
        
        // WHEN
        flowCoordinator.presentBreedDetailViewController(breedNames: (main:"", sub: ""))

        // THEN
        let currentVC = (window.rootViewController as? UINavigationController)?.visibleViewController
        XCTAssertEqual(currentVC, detailViewController)
    }
}
