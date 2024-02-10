//
//  BreedCoordinatorDependencyProviderType.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit

/// Protocol defning dependency providers, primarily view controllers, in use within Breed Coordinator.
protocol BreedCoordinatorDependencyProviderType {
    func breedNavigationController(coordinator: BreedCoordinatorType) -> UINavigationController
    func breedDetailViewController(breedNames: (main: String, sub: String), coordinator: BreedCoordinatorType) -> UIViewController
    func breedPhotoViewController(imageUrl: String) -> UIViewController
}
