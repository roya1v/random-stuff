//
//  ChatsViewController.swift
//  Tinderque-View
//
//  Created by Mike S. on 24/01/2024.
//

import UIKit

class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem = UITabBarItem(title: nil,
                                  image: UIImage(systemName: "bubble.fill"),
                                  tag: 1)
    }
}
