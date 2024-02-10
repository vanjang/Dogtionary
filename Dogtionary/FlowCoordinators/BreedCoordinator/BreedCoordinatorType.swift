//
//  BreedCoordinatorType.swift
//  Dogtionary
//
//  Created by myung hoon on 10/02/2024.
//

import Foundation

/// Protocol defining navigations that the coordinator is in charge of.
protocol BreedCoordinatorType: Coordinator {
    func presentBreedDetailViewController(breedNames: (main: String, sub: String))
    func presentBreedPhotoViewController(imageUrl: String)
}
