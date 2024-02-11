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
    private let logic: BreedListViewModelLogic
    private var cancellables: [AnyCancellable] = []

    init(useCase: BreedUseCaseType, coordinator: BreedCoordinatorType, logic: BreedListViewModelLogic) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.logic = logic
    }

    func connect(input: BreedListViewModelInput) -> BreedListViewModelOutput {
        let fetch = input.appear.share()
        
        let result = fetch
            .flatMap { [unowned self] in
                self.useCase.fetchBreeds()
            }
            .eraseToAnyPublisher()
            .share()
        
        input.selection
            .sink { [unowned self] selectedBreed in
                self.coordinator.presentBreedDetailViewController(breedNames: self.logic.getBreedNamesForFetchingImageUrls(from: selectedBreed))
            }
            .store(in: &cancellables)
        
        let searchInput = input.search
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
        
        let state = Publishers.Merge(result.map { _ in "" }, searchInput)
            .combineLatest(result)
            .map { [unowned self] (keyword: String, result) -> BreedListState in
                switch result {
                case .success(let breeds) where breeds.isEmpty: return .noResults
                case .success(let breeds):
                    let cellItems = self.logic.getBreedListCellItems(from: breeds)
                        .filter { item in
                            keyword.isEmpty || (item.displayName.range(of: keyword, options: .caseInsensitive) != nil)
                        }
                    return .success(cellItems)
                case .failure(let error): return .failure(error)
                }
            }
            .eraseToAnyPublisher()
        
        return Publishers.Merge(state, fetch.map { _ in .loading }).eraseToAnyPublisher()
    }
}
