//
//  MatchesTableViewCell.swift
//  Tinderque-View
//
//  Created by Mike S. on 01/02/2024.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let matchesView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.text = "New matches"

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
        ])

        contentView.addSubview(matchesView)
        matchesView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            matchesView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            matchesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            matchesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            matchesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        matchesView.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



