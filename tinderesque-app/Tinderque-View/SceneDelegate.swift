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
        window.rootViewController = getRootViewController()

        self.window = window
        window.makeKeyAndVisible()
    }

    fileprivate func getRootViewController() -> UIViewController {
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [
            MainViewController(),
            ChatsViewController()
        ]
        let navVC = UINavigationController(rootViewController: tabBarVC)
        return navVC
    }
}

#Preview {
    SceneDelegate().getRootViewController()
}
