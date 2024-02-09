//
//  BreedComponentsFactory.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit

final class BreedComponentsFactory {
    
}

extension BreedComponentsFactory: AppFlowCoordinatorDependencyProvider {
    func breedNavigationController(coordinator: BreedCoordinatorType) -> UINavigationController {
        let viewModel = BreedListViewModel(useCase: BreedUseCase(), coordinator: coordinator)
        let breedListViewController = BreedListViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: breedListViewController)
    }
    
    func breedListViewController(coordinator: BreedCoordinatorType) -> UIViewController {
        BreedListViewController(viewModel: BreedListViewModel(useCase: BreedUseCase(), coordinator: coordinator))
    }
    
    func breedDetailViewController(coordinator: BreedCoordinatorType) -> UIViewController {
        BreedDetailViewController(viewModel: BreedDetailViewModel(coordinator: coordinator))
    }
    
    func breedPhotoViewController() -> UIViewController {
        PhotoViewController()
    }
}
