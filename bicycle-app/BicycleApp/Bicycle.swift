//
//  Bicycle.swift
//  BicycleApp
//
//  Created by Mike S. on 03/07/2024.
//

import Foundation
import SwiftData

@Model
class Bicycle {

    @Attribute(.unique) var id: UUID
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
