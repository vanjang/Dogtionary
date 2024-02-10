//
//  BreedDetailViewModel.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit
import Combine

final class BreedDetailViewModel: BreedDetailViewModelType {
    private let breedNames: (main: String, sub: String)
    private let useCase: BreedUseCaseType
    private let coordinator: BreedCoordinatorType
    private var cancellables: [AnyCancellable] = []
    
    init(breedNames: (main: String, sub: String), useCase: BreedUseCaseType, coordinator: BreedCoordinatorType) {
        self.breedNames = breedNames
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func connect(input: BreedDetailViewModelInput) -> BreedDetailViewModelOuput {
        input.selection
            .sink { [unowned self] imageUrl in
                self.coordinator.presentBreedPhotoViewController(imageUrl: imageUrl)
            }
            .store(in: &cancellables)
        
        let status = input.appear
            .flatMap { [unowned self] _ in
                let mainPath = "/\(breedNames.main)"
                let subPath = breedNames.sub.isEmpty ? "/images" : "/\(breedNames.sub)/images"
                return self.useCase.fetchImageUrls(path: mainPath + subPath)
            }
            .map { result -> BreedDetailStatus in
                switch result {
                case .success(let urls) where urls.isEmpty: return .noResult
                case .success(let urls):
                    let items = urls.randomElements(count: 10).map {
                        BreedDetailCellItem(imageUrl: $0)
                    }
                    return .success(items)
                case .failure(let error): return .failure(error)
                }
            }
            .prepend(.loading)
        
        let title = (breedNames.sub.isEmpty ? breedNames.main : breedNames.sub).capitalizedFirstLetter()
        
        return BreedDetailViewModelOuput(breedName: Just(title).eraseToAnyPublisher(), status: status.eraseToAnyPublisher())
    }
    
    deinit {
        print("BreedDetailViewModel is deinitialised")
    }
}
