//
//  MainViewController.swift
//  Tinderque-View
//
//  Created by Mike S. on 22/01/2024.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        let card = ProfileCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 8 / 13)
        ])

        let dragger = UIPanGestureRecognizer()
        card.addGestureRecognizer(dragger)
        dragger.addTarget(self, action: #selector(panView))
        print(ProfileModel.mock())
    }

    private var center: CGPoint?


    @objc func panView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)

        if let viewToDrag = sender.view {
            if center == nil {
                center = viewToDrag.center
            }
            viewToDrag.center = CGPoint(x: viewToDrag.center.x + translation.x,
                y: viewToDrag.center.y + translation.y)
            viewToDrag.transform = viewToDrag.transform.rotated(by: translation.y * -0.05)
            if sender.state == .ended, let center {
                viewToDrag.center = center
                self.center = nil
                viewToDrag.transform = .identity
            }
            sender.setTranslation(CGPoint(x: 0, y: 0), in: viewToDrag)
        }

    }
}
