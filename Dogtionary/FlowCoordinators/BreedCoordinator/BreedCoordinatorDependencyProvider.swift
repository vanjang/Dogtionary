//
//  BreedCoordinatorDependencyProvider.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit

protocol BreedCoordinatorDependencyProvider {
    func breedNavigationController(coordinator: BreedCoordinatorType) -> UINavigationController
    func breedListViewController(coordinator: BreedCoordinatorType) -> UIViewController
    func breedDetailViewController(coordinator: BreedCoordinatorType) -> UIViewController
    func breedPhotoViewController() -> UIViewController
}
