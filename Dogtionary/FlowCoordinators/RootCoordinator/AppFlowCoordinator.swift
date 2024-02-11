//
//  AppFlowCoordinator.swift
//  Dogtionary
//
//  Created by myung hoon on 08/02/2024.
//

import UIKit

/// Main coordinator responsible for managing all the child coordinators(but this app has one child coordinator as it is a small project).
class AppFlowCoordinator: Coordinator {
    private let window: UIWindow
    private let dependencyProvider: AppFlowCoordinatorDependencyProvider
    private var childCoordinators = [Coordinator]()

    init(window: UIWindow, dependencyProvider: AppFlowCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let breedSearchFlowCoordinator = BreedCoordinator(window: window, dependencyProvider: dependencyProvider)
        childCoordinators = [breedSearchFlowCoordinator]
        breedSearchFlowCoordinator.start()
    }
}
