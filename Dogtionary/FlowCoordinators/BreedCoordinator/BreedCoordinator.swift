//
//  BreedCoordinator.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit

final class BreedCoordinator: BreedCoordinatorType {
    fileprivate let window: UIWindow
    fileprivate var navigationController: UINavigationController?
    fileprivate let dependencyProvider: BreedCoordinatorDependencyProviderType
    
    init(window: UIWindow, dependencyProvider: BreedCoordinatorDependencyProviderType) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }

    func start() {
        navigationController = dependencyProvider.breedNavigationController(coordinator: self)
        window.rootViewController = navigationController
    }

    func presentBreedDetailViewController(breedNames: (main: String, sub: String)) {
        navigationController?.pushViewController(dependencyProvider.breedDetailViewController(breedNames: breedNames, coordinator: self), animated: true)
    }

    func presentBreedPhotoViewController(imageUrl: String) {
        let modalViewController = dependencyProvider.breedPhotoViewController(imageUrl: imageUrl)
        modalViewController.modalPresentationStyle = .overFullScreen
        window.rootViewController?.present(modalViewController, animated: true)
    }
}
