//
//  BreedCoordinator.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit

protocol BreedCoordinatorType: Coordinator {
    func presentBreedListViewController()
    func presentBreedDetailViewController()
    func presentBreedPhotoViewController(image: UIImage)
}

final class BreedCoordinator: BreedCoordinatorType {
    fileprivate let window: UIWindow
    fileprivate var navigationController: UINavigationController?
    fileprivate let dependencyProvider: BreedCoordinatorDependencyProvider
    
    init(window: UIWindow, dependencyProvider: BreedCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }

    func start() {
        navigationController = dependencyProvider.breedNavigationController(coordinator: self)
        window.rootViewController = navigationController
    }

    func presentBreedDetailViewController() {
        navigationController?.pushViewController(dependencyProvider.breedDetailViewController(coordinator: self), animated: true)
    }

    func presentBreedListViewController() {
        navigationController?.pushViewController(dependencyProvider.breedListViewController(coordinator: self), animated: true)
    }
    
    func presentBreedPhotoViewController(image: UIImage) {
        let modalViewController = dependencyProvider.breedPhotoViewController()
        modalViewController.modalPresentationStyle = .overFullScreen
        window.rootViewController?.present(modalViewController, animated: true)
    }
}
