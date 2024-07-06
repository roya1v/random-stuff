//
//  ModelContainer.swift
//  BicycleApp
//
//  Created by Mike S. on 06/07/2024.
//

import Foundation
import Dependencies
import SwiftData

extension DependencyValues {
    var modelContainer: ModelContainer {
        get { self[ModelContainer.self] }
        set { self[ModelContainer.self] = newValue }
    }
}

extension ModelContainer: DependencyKey {
    public static var liveValue = try! ModelContainer(for: Bicycle.self, Ride.self, configurations: ModelConfiguration())
    public static var previewValue = try! ModelContainer(for: Bicycle.self, Ride.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
}
