//
//  BreedDetailCellItem.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import UIKit

struct BreedDetailCellItem {
    let image: UIImage
}

extension BreedDetailCellItem : Hashable {
    static func ==(lhs: BreedDetailCellItem, rhs: BreedDetailCellItem) -> Bool {
        return lhs.image == rhs.image
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
}
