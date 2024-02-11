//
//  MockBreedCoordinatorDependencyProvider.swift
//  DogtionaryTests
//
//  Created by myung hoon on 10/02/2024.
//

import UIKit
@testable import Dogtionary

class MockBreedCoordinatorDependencyProvider: BreedCoordinatorDependencyProviderType {
    var breedNavigationControllerTest: UINavigationController?
    var breedDetailViewControllerTest: UIViewController?
    var breedPhotoViewControllerTest: UIViewController?
    
    func breedNavigationController(coordinator: Dogtionary.BreedCoordinatorType) -> UINavigationController {
        breedNavigationControllerTest!
    }
    
    func breedDetailViewController(breedNames: (main: String, sub: String), coordinator: Dogtionary.BreedCoordinatorType) -> UIViewController {
        breedDetailViewControllerTest!
    }
    
    func breedPhotoViewController(imageUrl: String) -> UIViewController {
        breedPhotoViewControllerTest!
    }
}
