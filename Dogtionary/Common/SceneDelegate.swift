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
        
        // setup window
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
        // setup root coordinator
        appCoordinator = AppFlowCoordinator(window: window!, dependencyProvider: BreedComponentsFactory())
        appCoordinator.start()
    }
}

