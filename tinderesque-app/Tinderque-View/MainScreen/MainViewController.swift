//
//  MainViewController.swift
//  Tinderque-View
//
//  Created by Mike S. on 22/01/2024.
//

import UIKit

final class MainViewController: UIViewController {

    private let card = ProfileCardView()

    init() {
        super.init(nibName: nil, bundle: nil)

        tabBarItem = UITabBarItem(title: nil,
                                  image: UIImage(systemName: "flame.fill"),
                                  tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white

        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 8 / 13)
        ])

        let gestureDetector = UIPanGestureRecognizer()
        card.addGestureRecognizer(gestureDetector)
        gestureDetector.addTarget(self, action: #selector(cardWasPanned))


    }

    @objc func cardWasPanned(_ sender: UIPanGestureRecognizer) {

    }
}

#Preview {
    MainViewController()
}
