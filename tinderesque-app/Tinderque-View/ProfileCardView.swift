//
//  ProfileCard.swift
//  Tinderque-View
//
//  Created by Mike S. on 23/01/2024.
//

import UIKit

class ProfileCardView: UIView {

    let profile = ProfileModel.mock()

    lazy var indicator = ProfileImageIndicatorView(numberOfSections: profile.images.count)
    var currentImage: Int {
        get {
            indicator.current
        }
        set {
            if newValue >= profile.images.count {
                indicator.current = 0
            } else if newValue < 0 {
                indicator.current = profile.images.count - 1
            } else {
                indicator.current = newValue
            }
        }
    }
    let imageView = UIImageView(frame: .zero)

    init() {
        super.init(frame: .zero)
        backgroundColor = .red


        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        imageView.image = profile.images[0]
        imageView.contentMode = .scaleAspectFill

        let tapGestureRecognizer = UITapGestureRecognizer()

        addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(onTap))


        indicator.translatesAutoresizingMaskIntoConstraints = false

        addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            indicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            indicator.heightAnchor.constraint(equalToConstant: 4.0),
            indicator.topAnchor.constraint(equalTo: topAnchor, constant: 8.0)
        ])
        layer.masksToBounds = true
        layer.cornerRadius = 16.0
    }

    @objc func onTap(_ sender: UITapGestureRecognizer) {
        print()
        let tapLocation = sender.location(in: self)
        if tapLocation.x > frame.width / 2 {
            currentImage += 1
        } else {
            currentImage -= 1
        }
        imageView.image = profile.images[currentImage]
        indicator.current = currentImage
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    let vc = MainViewController()
    return vc
}
