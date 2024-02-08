//
//  BreedListCellItem.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import Foundation

struct BreedListCellItem {
    let breedName: String
    let hasSubBreeds: Bool
    let isSubBreed: Bool
    let isExpanded: Bool
}

extension BreedListCellItem: Hashable {
    static func ==(lhs: BreedListCellItem, rhs: BreedListCellItem) -> Bool {
        return lhs.breedName == rhs.breedName
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(breedName)
    }
}
