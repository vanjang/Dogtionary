//
//  BreedDetailViewModelType.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit
import Combine

typealias BreedDetailViewModelInput = AnyPublisher<UIImage, Never>
typealias BreedDetailViewModelOuput = AnyPublisher<[BreedDetailCellItem], Never>

protocol BreedDetailViewModelType {
    func transform(input: BreedDetailViewModelInput) -> BreedDetailViewModelOuput
}
