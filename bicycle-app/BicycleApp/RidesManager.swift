//
//  RidesManager.swift
//  BicycleApp
//
//  Created by Mike S. on 02/07/2024.
//

import Foundation
import Dependencies
import SwiftData

extension DependencyValues {
    var ridesManager: RidesManager {
        get { self[RidesManager.self] }
        set { self[RidesManager.self] = newValue }
    }
}

extension RidesManager: DependencyKey {
    public static var liveValue = Self()
    public static var previewValue = Self()
}

struct RidesManager: Sendable {
    
    @Dependency(\.modelContainer) var dbContainer: ModelContainer
    
    @MainActor
    func save(ride: Ride) async throws {
        let context = dbContainer.mainContext
        context.insert(ride)
    }
   
    @MainActor
    func getAllExisting() async throws -> [Ride] {
        let context = dbContainer.mainContext
        return try! context.fetch(.init())
    }
}
