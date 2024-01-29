//
//  MainViewController.swift
//  Tinderque-View
//
//  Created by Mike S. on 22/01/2024.
//

import UIKit

final class MainViewController: UIViewController {

    private let card = ProfileCardView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 8 / 13)
        ])

        let gestureDetector = UIPanGestureRecognizer()
        card.addGestureRecognizer(gestureDetector)
        gestureDetector.addTarget(self, action: #selector(cardWasPanned))

        tabBarItem = UITabBarItem(title: nil,
                                  image: UIImage(systemName: "flame.fill"),
                                  tag: 0)
    }

    @objc func cardWasPanned(_ sender: UIPanGestureRecognizer) {

    }
}

#Preview {
    MainViewController()
}
