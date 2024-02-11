//
//  BreedListViewModelLogicTests.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import XCTest
@testable import Dogtionary

final class BreedListViewModelLogicTests: XCTestCase {
    let logic = BreedListViewModelLogic()

    func testBreedListCellItems() throws {
        // GIVEN
        let breeds: [Breed] = [Breed(name: "affenpinscher", subBreeds: []),
                               Breed(name: "malamute", subBreeds: []),
                               Breed(name: "hound", subBreeds: ["afghan", "blood", "enlgish"]),]
        
        let cellItems = logic.getBreedListCellItems(from: breeds)
        
        // WHEN
        let expected: [BreedListCellItem] = [BreedListCellItem(displayName: "Affenpinscher", isSubBreed: false, mainBreedName: "affenpinscher"),
                                             BreedListCellItem(displayName: "Hound", isSubBreed: false, mainBreedName: "hound"),
                                             BreedListCellItem(displayName: "Afghan", isSubBreed: true, mainBreedName: "hound"),
                                             BreedListCellItem(displayName: "Blood", isSubBreed: true, mainBreedName: "hound"),
                                             BreedListCellItem(displayName: "Enlgish", isSubBreed: true, mainBreedName: "hound"),
                                             BreedListCellItem(displayName: "Malamute", isSubBreed: false, mainBreedName: "malamute")]
        
        // THEN
        XCTAssertEqual(cellItems, expected, "cell items are NOT identical!")
    }
    
    func testBreeNamesForFetchingImageUrls() throws {
        // GIVEN
        let cellItems1 = BreedListCellItem(displayName: "Affenpinscher", isSubBreed: false, mainBreedName: "affenpinscher")
        let cellItems2 = BreedListCellItem(displayName: "Afghan", isSubBreed: true, mainBreedName: "hound")

        let breedNames1 = (main: "affenpinscher", sub: "")
        let breedNames2 = (main: "hound", sub: "afghan")

        // WHEN
        let expected1 = logic.getBreedNamesForFetchingImageUrls(from: cellItems1)
        let expected2 = logic.getBreedNamesForFetchingImageUrls(from: cellItems2)
        
        // THEN
        XCTAssertEqual(breedNames1.main, expected1.main)
        XCTAssertEqual(breedNames1.sub, expected1.sub)
        XCTAssertEqual(breedNames2.main, expected2.main)
        XCTAssertEqual(breedNames2.sub, expected2.sub)
    }
}
