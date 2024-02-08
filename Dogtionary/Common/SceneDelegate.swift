//
//  SceneDelegate.swift
//  Dogtionary
//
//  Created by myung hoon on 06/02/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let vc = UINavigationController(rootViewController: BreedListViewController())
        window?.rootViewController = vc
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}

