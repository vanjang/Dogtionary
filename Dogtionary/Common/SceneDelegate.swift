//
//  SceneDelegate.swift
//  Dogtionary
//
//  Created by myung hoon on 06/02/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppFlowCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }        
        // Setup window
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
        // Setup root coordinator
        appCoordinator = AppFlowCoordinator(window: window!, dependencyProvider: BreedCoordinatorDependencyProvider(service: NetworkService()))
        appCoordinator.start()
        
        // Configure cache capacity
        let memoryCapacity = 20 * 1024 * 1024 // 20 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        URLCache.configSharedCache(memory: memoryCapacity, disk: diskCapacity)
    }
}

