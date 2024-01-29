//
//  ProfileImageIndicatorView.swift
//  Tinderque-View
//
//  Created by Mike S. on 23/01/2024.
//

import UIKit

final class ProfileImageIndicatorView: UIView {

    private let stackView = UIStackView()

    var current: Int = 0 {
        willSet {
            stackView.arrangedSubviews[current].backgroundColor = .gray
            stackView.arrangedSubviews[newValue].backgroundColor = .white
        }
    }

    init(numberOfSections: Int) {
        super.init(frame: .zero)

        setupView(withNumberOfSections: numberOfSections)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(withNumberOfSections: Int) {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        (1...withNumberOfSections)
            .map { _ in
                let view = UIView(frame: .zero)
                view.backgroundColor = .white
                view.backgroundColor = .gray
                view.layer.cornerRadius = 2.0
                return view
            }
            .forEach {
                stackView.addArrangedSubview($0)
            }
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
    }
}
