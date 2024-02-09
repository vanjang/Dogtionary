//
//  Breed.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation

struct BreedResponse: Codable {
    let message: [String: [String]]
    let status: String
}

extension BreedResponse {
    func toBreeds() -> [Breed] {
        var dogBreeds: [Breed] = []
        for (breedName, subBreeds) in message {
            let dogBreed = Breed(name: breedName, subBreeds: subBreeds)
            dogBreeds.append(dogBreed)
        }
        return dogBreeds
    }
}

struct Breed: Decodable {
    let name: String
    let subBreeds: [String]
}
