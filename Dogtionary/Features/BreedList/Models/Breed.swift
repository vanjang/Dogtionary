//
//  Breed.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation

struct Breed: Decodable {
    let name: String
    let subBreeds: [String]
}
