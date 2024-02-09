//
//  BreedListViewModelType.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import Combine

struct BreedSearchViewModelInput {
    /// called when a screen becomes visible
    let appear: AnyPublisher<Void, Never>
    /// triggered when the search query is updated
    let search: AnyPublisher<String, Never>
    /// called when the user selected an item from the list
    let selection: AnyPublisher<String, Never>
}

enum BreedSearchState {
    case loading
    case success([BreedListCellItem])
    case noResults
    case failure(Error)
}

extension BreedSearchState: Equatable {
    static func == (lhs: BreedSearchState, rhs: BreedSearchState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhsMovies), .success(let rhsMovies)): return lhsMovies == rhsMovies
        case (.noResults, .noResults): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias BreedSearchViewModelOuput = AnyPublisher<BreedSearchState, Never>

protocol BreedListViewModelType {
    func transform(input: BreedSearchViewModelInput) -> BreedSearchViewModelOuput
}
