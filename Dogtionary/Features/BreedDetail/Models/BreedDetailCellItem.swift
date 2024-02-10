//
//  BreedDetailCellItem.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

struct BreedDetailCellItem {
    let imageUrl: String
}

extension BreedDetailCellItem : Hashable {
    static func ==(lhs: BreedDetailCellItem, rhs: BreedDetailCellItem) -> Bool {
        return lhs.imageUrl == rhs.imageUrl
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(imageUrl)
    }
}
