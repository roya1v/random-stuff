//
//  MatchesTableViewCell.swift
//  Tinderque-View
//
//  Created by Mike S. on 01/02/2024.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

    lazy var layout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { (_, _)  in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/5),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            group.contentInsets = .init(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous

            return section
        }

    }()

    let titleLabel = UILabel()
    lazy var matchesView = UICollectionView(frame: .zero, collectionViewLayout: layout)

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

        matchesView.dataSource = self
        matchesView.register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: "test2")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MatchesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProfileService.shared.getProfiles().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test2", for: indexPath) as? MatchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = ProfileService.shared.getImages().first
        cell.nameLabel.text = ProfileService.shared.getProfiles()[indexPath.row].name
        return cell
    }
}

class MatchCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()
    let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        layer.masksToBounds = true

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])

        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
