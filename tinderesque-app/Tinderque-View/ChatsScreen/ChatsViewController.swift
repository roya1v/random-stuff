//
//  ChatsViewController.swift
//  Tinderque-View
//
//  Created by Mike S. on 24/01/2024.
//

import UIKit

class ChatsViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)

        tabBarItem = UITabBarItem(title: nil,
                                  image: UIImage(systemName: "bubble.fill"),
                                  tag: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
