//
//  BreedUserCase.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation
import Combine

final class BreedUseCase: BreedUseCaseType {
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func fetchBreeds() -> AnyPublisher<Result<[Breed], Error>, Never> {
        networkService.request(BreedEndpoint(path: "breeds/list/all", method: .get, parameters: nil, headers: nil))
            .map { (response: Response<[String: [String]]>) -> Result<[Breed], Error> in
                var breeds: [Breed] = []
                response.message.forEach {
                    let breed = Breed(name: $0.key, subBreeds: $0.value)
                    breeds.append(breed)
                }
                return .success(breeds)
            }
            .catch { error -> AnyPublisher<Result<[Breed], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchImageUrls(path: String) -> AnyPublisher<Result<[String], Error>, Never> {
        networkService.request(BreedEndpoint(path: "breed\(path)", method: .get, parameters: nil, headers: nil))
            .map { (response: Response<[String]>) in .success(response.message) }
            .catch { error -> AnyPublisher<Result<[String], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
