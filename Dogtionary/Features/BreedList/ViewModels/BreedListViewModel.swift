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

    func connect(input: BreedSearchViewModelInput) -> BreedSearchViewModelOuput {
        let fetch = input.appear.share()
        
        let result = fetch
            .flatMap { [unowned self] in
                self.useCase.fetchBreeds()
            }
            .eraseToAnyPublisher()
            .share()
        
        input.selection
            .sink { [unowned self] selectedBreed in
                let main: String = selectedBreed.mainBreedName?.lowercased() ?? ""
                let sub: String = selectedBreed.isSubBreed ? selectedBreed.displayName.lowercased() : ""
                self.coordinator.presentBreedDetailViewController(breedNames: (main: main, sub: sub))
            }
            .store(in: &cancellables)
        
        let searchInput = input.search
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
        
        let state = Publishers.Merge(result.map { _ in "" }, searchInput)
            .combineLatest(result)
            .map { (keyword: String, result) -> BreedListState in
                switch result {
                case .success(let breeds) where breeds.isEmpty: return .noResults
                case .success(let breeds):
                    let cellItems = breeds.sorted { $0.name < $1.name }
                        .flatMap { breed -> [BreedListCellItem] in
                            // Some breeds have only one sub-breed and it is the same with the main breed. In that case, only shows the main breed.
                            if breed.subBreeds.count <= 1 {
                                return [BreedListCellItem(displayName: breed.name.capitalizedFirstLetter(), isSubBreed: false, mainBreedName: breed.name)]
                            } else {
                                let mainBreedItem = BreedListCellItem(displayName: breed.name.capitalizedFirstLetter(), isSubBreed: false, mainBreedName: breed.name)
                                let subBreedItems = breed.subBreeds.map {
                                    BreedListCellItem(displayName: $0.capitalizedFirstLetter(), isSubBreed: true, mainBreedName: breed.name)
                                }
                                return [mainBreedItem] + subBreedItems
                            }
                        }
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
