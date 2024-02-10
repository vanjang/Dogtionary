//
//  BreedDetailViewModelType.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit
import Combine

struct BreedDetailViewModelInput {
    let appear: AnyPublisher<Void, Never>
    let selection: AnyPublisher<String, Never>
}

struct BreedDetailViewModelOuput {
    let breedName: AnyPublisher<String, Never>
    let status: AnyPublisher<BreedDetailStatus, Never>
}

protocol BreedDetailViewModelType {
    func connect(input: BreedDetailViewModelInput) -> BreedDetailViewModelOuput
}

enum BreedDetailStatus {
    case failure(Error)
    case loading
    case noResult
    case success([BreedDetailCellItem])
}
