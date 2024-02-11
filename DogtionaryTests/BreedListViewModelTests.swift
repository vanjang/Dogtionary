//
//  BreedListViewModelTests.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import XCTest
import Combine
@testable import Dogtionary

final class BreedListViewModelTests: XCTestCase {
    private let useCase = MockBreedUseCase()
    private let coordinator = MockBreedCoordinator()
    private let logic = BreedListViewModelLogic()
    private var viewModel: BreedListViewModel!
    private var cancellables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        viewModel = BreedListViewModel(useCase: useCase, coordinator: coordinator, logic: logic)
    }
    
    func testBreedListState() throws {
        // GIVEN
        let appear = PassthroughSubject<Void, Never>()
        let input = BreedListViewModelInput(appear: appear.eraseToAnyPublisher(), search: .empty(), selection: .empty())
        let expectation = self.expectation(description: "state")
        var cellItems: [BreedListCellItem] = []
        let output = viewModel.connect(input: input)
                
        // WHEN
        output
            .sink { state in
                switch state {
                case .success(let items):
                    if !items.isEmpty {
                        cellItems = items
                        expectation.fulfill()
                    }
                default: print("")
                }
            }
            .store(in: &cancellables)
        
        // THEN
        appear.send(())

        waitForExpectations(timeout: 1)
        
        XCTAssert(!cellItems.isEmpty)
    }
    
    func testBreedListSearch() throws {
        // GIVEN
        let appear = PassthroughSubject<Void, Never>()
        let search = PassthroughSubject<String, Never>()
        let input = BreedListViewModelInput(appear: appear.eraseToAnyPublisher(), search: search.eraseToAnyPublisher(), selection: .empty())
        let expectation = self.expectation(description: "state")
        var foundSearechResult: Bool = false
        let output = viewModel.connect(input: input)
                
        // WHEN
        output
            .sink { state in
                switch state {
                case .success(let items):
                    if items.first?.displayName == "Bulldog" {
                        foundSearechResult = true
                        expectation.fulfill()
                    }
                default: print("")
                }
            }
            .store(in: &cancellables)
        
        // THEN
        appear.send(())
       
        search.send("bulldog")

        waitForExpectations(timeout: 1)
        
        XCTAssert(foundSearechResult)
    }
}
