//
//  MockAppFlowCoordinatorDependencyProvider.swift
//  DogtionaryTests
//
//  Created by myung hoon on 10/02/2024.
//

import UIKit
@testable import Dogtionary

class MockAppFlowCoordinatorDependencyProvider: AppFlowCoordinatorDependencyProvider {
    var breedNavigationControllerTest: UINavigationController?
    var breedDetailViewController: UIViewController?
    var photoViewController: UIViewController?
    
    func breedNavigationController(coordinator: Dogtionary.BreedCoordinatorType) -> UINavigationController {
        breedNavigationControllerTest!
    }
    
    func breedDetailViewController(breedNames: (main: String, sub: String), coordinator: Dogtionary.BreedCoordinatorType) -> UIViewController {
        breedDetailViewController!
    }
    
    func breedPhotoViewController(imageUrl: String) -> UIViewController {
        photoViewController!
    }
}
