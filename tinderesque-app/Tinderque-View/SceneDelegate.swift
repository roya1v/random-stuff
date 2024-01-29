//
//  SceneDelegate.swift
//  Tinderque-View
//
//  Created by Mike S. on 22/01/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [MainViewController()]
        window.rootViewController = tabBarVC


        self.window = window
        window.makeKeyAndVisible()
    }
}

#Preview {
    let tabBarVC = UITabBarController()
    tabBarVC.viewControllers = [
        MainViewController(),
        ChatsViewController()
    ]
    return tabBarVC
}
