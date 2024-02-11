//
//  MockBreedUseCase.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import Combine
import XCTest
@testable import Dogtionary

final class MockBreedUseCase: BreedUseCaseType {
    func fetchBreeds() -> AnyPublisher<Result<[Dogtionary.Breed], Error>, Never> {
        var breeds: [Breed] = []
        do {
            let response = try JSONDecoder().decode(Response<[String: [String]]>.self, from: MockData.allBreedsJsonData)
            response.message.forEach {
                let breed = Breed(name: $0.key, subBreeds: $0.value)
                breeds.append(breed)
            }
        } catch {
            XCTFail("Failed to decode from response: \(error.localizedDescription)")
        }
        return .just(.success(breeds))
    }
    
    func fetchImageUrls(path: String) -> AnyPublisher<Result<[String], Error>, Never> {
        var urls: [String] = []
        do {
            let response = try JSONDecoder().decode(Response<[String]>.self, from: MockData.imageUrlsJsonData)
            urls = response.message
        } catch {
            XCTFail("Failed to decode from response: \(error.localizedDescription)")
        }
        return .just(.success(urls))
    }
}
