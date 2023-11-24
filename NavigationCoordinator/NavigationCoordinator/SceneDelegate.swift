//
//  SceneDelegate.swift
//  NavigationCoordinator
//
//  Created by Daniel Camarena on 11/24/23.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    private let coordinator: Coordinator<MapRouter> = .init(startingRoute: .map)
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
    
}
