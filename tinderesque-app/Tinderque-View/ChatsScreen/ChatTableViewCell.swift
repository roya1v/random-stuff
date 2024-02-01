//
//  ChatTableViewCell.swift
//  Tinderque-View
//
//  Created by Mike S. on 29/01/2024.
//

import UIKit

final class ChatTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let lastMessageLabel = UILabel()
    private let userImageView = UIImageView()

    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }

    var lastMessage: String? {
        didSet {
            lastMessageLabel.text = lastMessage
        }
    }

    var userImage: UIImage? {
        didSet {
            userImageView.image = userImage

        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6.5),
            userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6.5),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor)
        ])
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true

        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 11.0),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -4.0)
        ])

        contentView.addSubview(lastMessageLabel)
        lastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        lastMessageLabel.textColor = .systemGray
        NSLayoutConstraint.activate([
            lastMessageLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 11.0),
            lastMessageLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 4.0)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
    }

}

#Preview {
    ChatsViewController()
}
