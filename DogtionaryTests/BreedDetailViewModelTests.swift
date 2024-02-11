//
//  BreedDetailViewModelTests.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import XCTest
import Combine
@testable import Dogtionary

final class BreedDetailViewModelTests: XCTestCase {
    private let useCase = MockBreedUseCase()
    private let coordinator = MockBreedCoordinator()
    private let logic = BreedListViewModelLogic()
    private var viewModel: BreedDetailViewModel!
    private var cancellables: [AnyCancellable] = []
    
    func testTitle() throws {
        // GIVEN
        let breedNames = (main: "bulldog", sub: "english")
        viewModel = BreedDetailViewModel(breedNames: breedNames, useCase: useCase, coordinator: coordinator)
        
        let appear = PassthroughSubject<Void, Never>()
        let input = BreedDetailViewModelInput(appear: appear.eraseToAnyPublisher(), selection: .empty())
        let output = viewModel.connect(input: input)
        
        let expectation = self.expectation(description: "state")
        
        var navBarTitle: String = ""
        
        // WHEN
        output.breedName
            .sink { title in
                navBarTitle = title
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // THEN
        appear.send(())

        waitForExpectations(timeout: 1)
        
        XCTAssert(navBarTitle == "English")
    }
    
    func testFetchingImageUrlsSuccessfully() throws {
        // GIVEN
        let breedNames = (main: "bulldog", sub: "english")
        viewModel = BreedDetailViewModel(breedNames: breedNames, useCase: useCase, coordinator: coordinator)
        
        let appear = PassthroughSubject<Void, Never>()
        let input = BreedDetailViewModelInput(appear: appear.eraseToAnyPublisher(), selection: .empty())
        let output = viewModel.connect(input: input)
        
        let expectation = self.expectation(description: "state")
        
        var cellItems: [BreedDetailCellItem] = []
        
        // WHEN
        output.status
            .sink { status in
                switch status {
                case .success(let items):
                    if !items.isEmpty {
                        cellItems = items
                        expectation.fulfill()
                    }
                default: break
                }
            }
            .store(in: &cancellables)
        
        // THEN
        appear.send(())

        waitForExpectations(timeout: 1)
        
        XCTAssert(!cellItems.isEmpty)
    }

}
