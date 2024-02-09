//
//  BreedDetailViewModel.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit
import Combine

final class BreedDetailViewModel: BreedDetailViewModelType {
    private let coordinator: BreedCoordinatorType
    private var cancellables: [AnyCancellable] = []
    
    init(coordinator: BreedCoordinatorType) {
        self.coordinator = coordinator
    }
    
    func transform(input: BreedDetailViewModelInput) -> BreedDetailViewModelOuput {
        input
            .sink { [unowned self] image in
                self.coordinator.presentBreedPhotoViewController(image: image)
            }
            .store(in: &cancellables)
        
        let temp: [BreedDetailCellItem] = [
            BreedDetailCellItem(image: UIImage(named: "doggys")!),
        ]
        
        return Just(temp).eraseToAnyPublisher()
    }
    
    
}
