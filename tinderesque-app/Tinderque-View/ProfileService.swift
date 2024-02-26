//
//  ProfileModel.swift
//  Tinderque-View
//
//  Created by Mike S. on 23/01/2024.
//

import UIKit

struct Profile: Codable {
    let name: String
    let age: Int
    let distance: Int
}

final class ProfileService {
    private init() { }
    static let shared = ProfileService()

    func getProfiles() -> [Profile] {
        guard let dataURL = Bundle.main.url(forResource: "Profile", withExtension: "json"),
              let data = try? Data(contentsOf: dataURL),
              let profiles = try? JSONDecoder().decode([Profile].self, from: data) else {
            fatalError("Could load local mock")
        }
        return profiles
    }

    func getImages() -> [UIImage] {
        (1...5)
            .lazy
            .compactMap { Bundle.main.path(forResource: "\($0)", ofType: "jpg") }
            .compactMap { UIImage(contentsOfFile: $0) }
            .shuffled()
    }
}
