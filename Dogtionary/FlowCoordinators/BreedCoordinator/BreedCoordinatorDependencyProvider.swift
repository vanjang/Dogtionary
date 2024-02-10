//
//  BreedCoordinatorDependencyProvider.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit

final class BreedCoordinatorDependencyProvider {
    private let service: NetworkServiceType
    
    init(service: NetworkServiceType) {
        self.service = service
    }
}

extension BreedCoordinatorDependencyProvider: AppFlowCoordinatorDependencyProvider {
    func breedNavigationController(coordinator: BreedCoordinatorType) -> UINavigationController {
        let viewModel = BreedListViewModel(useCase: BreedUseCase(networkService: service), coordinator: coordinator)
        let breedListViewController = BreedListViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: breedListViewController)
    }
    
    func breedDetailViewController(breedNames: (main: String, sub: String), coordinator: BreedCoordinatorType) -> UIViewController {
        BreedDetailViewController(viewModel: BreedDetailViewModel(breedNames: breedNames, useCase: BreedUseCase(networkService: service), coordinator: coordinator))
    }
    
    func breedPhotoViewController(imageUrl: String) -> UIViewController {
        PhotoViewController(imageUrl: imageUrl)
    }
}
