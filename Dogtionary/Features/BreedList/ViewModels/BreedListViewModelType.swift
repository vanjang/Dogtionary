//
//  BreedListViewModelType.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import Combine

struct BreedSearchViewModelInput {
    let appear: AnyPublisher<Void, Never>
    let search: AnyPublisher<String, Never>
    let selection: AnyPublisher<BreedListCellItem, Never>
}

typealias BreedSearchViewModelOuput = AnyPublisher<BreedListState, Never>

enum BreedListState {
    case loading
    case success([BreedListCellItem])
    case noResults
    case failure(Error)
}

protocol BreedListViewModelType {
    func connect(input: BreedSearchViewModelInput) -> BreedSearchViewModelOuput
}
