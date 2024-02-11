//
//  BreedUseCaseType.swift
//  Dogtionary
//
//  Created by myung hoon on 10/02/2024.
//

import Foundation
import Combine

/// Protocol defining the core use cases for the Dog breed API.
protocol BreedUseCaseType {
    func fetchBreeds() -> AnyPublisher<Result<[Breed], Error>, Never>
    func fetchImageUrls(path: String) -> AnyPublisher<Result<[String], Error>, Never>
}
