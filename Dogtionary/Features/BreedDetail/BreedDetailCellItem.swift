//
//  BreedDetailCellItem.swift
//  Dogtionary
//
//  Created by myung hoon on 07/02/2024.
//

import Foundation

struct BreedDetailCellItem {
    let uuid = UUID()
}

extension BreedDetailCellItem : Hashable {
    static func ==(lhs: BreedDetailCellItem, rhs: BreedDetailCellItem) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
