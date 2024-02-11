//
//  BreedListViewModelLogic.swift
//  Dogtionary
//
//  Created by myung hoon on 11/02/2024.
//

import Foundation

struct BreedListViewModelLogic {
    func getBreedListCellItems(from breeds: [Breed]) -> [BreedListCellItem] {
        breeds
            .sorted { $0.name < $1.name }
            .flatMap { breed -> [BreedListCellItem] in
                // Some breeds have only one sub-breed and it is the same with the main breed. In that case, only show the main breed.
                if breed.subBreeds.count <= 1 {
                    return [BreedListCellItem(displayName: breed.name.capitalizedFirstLetter(), isSubBreed: false, mainBreedName: breed.name)]
                } else {
                    let mainBreedItem = BreedListCellItem(displayName: breed.name.capitalizedFirstLetter(), isSubBreed: false, mainBreedName: breed.name)
                    let subBreedItems = breed.subBreeds.map {
                        BreedListCellItem(displayName: $0.capitalizedFirstLetter(), isSubBreed: true, mainBreedName: breed.name)
                    }.sorted { $0.displayName < $1.displayName }
                    return [mainBreedItem] + subBreedItems
                }
            }
    }
    
    func getBreedNamesForFetchingImageUrls(from selectedItem: BreedListCellItem) -> (main: String, sub: String) {
        let main: String = selectedItem.mainBreedName?.lowercased() ?? ""
        let sub: String = selectedItem.isSubBreed ? selectedItem.displayName.lowercased() : ""
        return (main, sub)
    }
}
