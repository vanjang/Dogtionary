//
//  BreedUseCaseTests.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import XCTest
import Combine
@testable import Dogtionary

final class BreedUseCaseTests: XCTestCase {
    private var networkService: MockNetworkService!
    
    private var useCase: BreedUseCase!
    
    private var cancellables: [AnyCancellable] = []
    
    func testFetchingBreeds() throws {
        // GIVEN
        networkService = MockNetworkService(responseData: MockData.allBreedsJsonData)
        useCase = BreedUseCase(networkService: networkService)
            
        var result: Result<[Breed], Error>!
        let expectation = self.expectation(description: "breeds")
        
        // When
        useCase.fetchBreeds()
            .sink { value in
                result = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .success = result! else {
            XCTFail()
            return
        }
    }
    
    func testFetchingBreedsWithError() throws {
        // GIVEN
        networkService = MockNetworkService(responseError: TestError.test)
        useCase = BreedUseCase(networkService: networkService)
            
        var result: Result<[Breed], Error>!
        let expectation = self.expectation(description: "breeds")
        
        // When
        useCase.fetchBreeds()
            .sink { value in
                result = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .failure(let error) = result else {
            XCTFail()
            return
        }
        print(error)
    }
    
    func testFecthingImageUrls() throws {
        // GIVEN
        networkService = MockNetworkService(responseData: MockData.imageUrlsJsonData)
        useCase = BreedUseCase(networkService: networkService)
            
        var result: Result<[String], Error>!
        let expectation = self.expectation(description: "breeds")
        
        // WHEN
        useCase.fetchImageUrls(path: "hound-afghan")
            .sink { value in
                result = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 3.0, handler: nil)
        guard case .success = result! else {
            XCTFail()
            return
        }
    }
    
    func testFetchingImageUrlsWithError() throws {
        // GIVEN
        networkService = MockNetworkService(responseError: TestError.test)
        useCase = BreedUseCase(networkService: networkService)
            
        var result: Result<[String], Error>!
        let expectation = self.expectation(description: "breeds")
        
        // When
        useCase.fetchImageUrls(path: "hound-afghan")
            .sink { value in
                result = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 3.0, handler: nil)
        guard case .failure(let error) = result else {
            XCTFail()
            return
        }
        print(error)
    }
}
