//
//  BreedListViewModel.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import Foundation
import Combine

final class BreedListViewModel: BreedListViewModelType {
    private let useCase: BreedUseCaseType
    private let coordinator: BreedCoordinatorType
    private var cancellables: [AnyCancellable] = []

    init(useCase: BreedUseCaseType, coordinator: BreedCoordinatorType) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    func transform(input: BreedSearchViewModelInput) -> BreedSearchViewModelOuput {
        let result = useCase.getBreeds()
        
        input.selection
            .combineLatest(result.compactMap { try? $0.get() })
            .sink { [unowned self] selectedBreed, breeds in
                let selected = breeds.first { $0.name.lowercased() == selectedBreed.lowercased() }
                let hasSubBreeds = !(selected?.subBreeds.isEmpty ?? false)
                
                if hasSubBreeds {
                    self.coordinator.presentBreedListViewController()
                } else {
                    self.coordinator.presentBreedDetailViewController()
                }
            }
            .store(in: &cancellables)
        
        let searchInput = input.search
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
        
        let state = Publishers.Merge(input.appear.eraseToAnyPublisher().map { _ in "" }, searchInput.eraseToAnyPublisher())
            .combineLatest(result)
            .map { (keyword: String, result) -> BreedSearchState in
                switch result {
                case .success(let breeds) where breeds.isEmpty: return .noResults
                case .success(let breeds):
                    
                    let sortedBreeds = breeds.sorted { $0.name < $1.name }
                    
                    let filteredBreeds = keyword.isEmpty ? sortedBreeds : sortedBreeds.filter { $0.name.lowercased().range(of: keyword.lowercased()) != nil }
                    
                    let cellItem = filteredBreeds.map {
                        let subBreedItems =  $0.subBreeds.map { BreedListCellItem(breedName: $0.capitalizedFirstLetter(), subBreeds: [], isSubBreed: false, isAll: false)}
                        return BreedListCellItem(breedName: $0.name.capitalizedFirstLetter(), subBreeds: subBreedItems, isSubBreed: false, isAll: false)
                    }
                    
                    return .success(cellItem)
                case .failure(let error): return .failure(error)
                }
                
            }
            .prepend(.loading)
            .eraseToAnyPublisher()
            
        return state
    }
}
