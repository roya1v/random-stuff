//
//  ProfileModel.swift
//  Tinderque-View
//
//  Created by Mike S. on 23/01/2024.
//

import UIKit

struct _ProfileJsonModel: Codable {
    let name: String
    let age: Int
    let distance: Int
}

struct ProfileModel {
    let name: String
    let age: Int
    let distance: Int
    let images: [UIImage]
}

extension ProfileModel {
    private static func images() -> [UIImage] {
        (1...5)
            .lazy
            .compactMap { Bundle.main.path(forResource: "\($0)", ofType: "jpg") }
            .compactMap { UIImage(contentsOfFile: $0) }
    }


    static func mock() -> Self {
        guard let dataURL = Bundle.main.url(forResource: "Profile", withExtension: "json"),
              let data = try? Data(contentsOf: dataURL),
              let profile = try? JSONDecoder().decode(_ProfileJsonModel.self, from: data) else {
            fatalError("Could load local mock")
        }
        return ProfileModel(name: profile.name, age: profile.age, distance: profile.distance, images: images())
    }
}
