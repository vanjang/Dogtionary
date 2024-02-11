//
//  MockBreedCoordinator.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import Foundation
@testable import Dogtionary

final class MockBreedCoordinator: BreedCoordinatorType {
    func presentBreedDetailViewController(breedNames: (main: String, sub: String)) {}
    func presentBreedPhotoViewController(imageUrl: String) {}
    func start() {}
}
