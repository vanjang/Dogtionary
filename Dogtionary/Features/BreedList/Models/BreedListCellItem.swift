//
//  BreedListCellItem.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import Foundation

/// Item containing properties for populating cell
struct BreedListCellItem : Equatable {
    let displayName: String
    let isSubBreed: Bool
    let mainBreedName: String?
}
