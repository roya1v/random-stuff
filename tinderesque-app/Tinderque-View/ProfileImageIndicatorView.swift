//
//  ProfileImageIndicatorView.swift
//  Tinderque-View
//
//  Created by Mike S. on 23/01/2024.
//

import UIKit

class ProfileImageIndicatorView: UIView {

    var current: Int = 0 {
        willSet {
            stackView.arrangedSubviews[current].backgroundColor = .gray
            stackView.arrangedSubviews[newValue].backgroundColor = .white
        }
    }

    let stackView = UIStackView()

    init(numberOfSections: Int) {
        super.init(frame: .zero)


        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let views = (1...numberOfSections)
            .map { _ in UIView(frame: .zero) }
        views.forEach { $0.backgroundColor = .gray
            $0.layer.cornerRadius = 2.0
        }
        views[0].backgroundColor = .white
        views.forEach(stackView.addArrangedSubview)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    let vc = MainViewController()
    return vc
}

