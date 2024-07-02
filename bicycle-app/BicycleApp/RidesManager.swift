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
    public static let testValue = Self.live
    public static var liveValue = Self.live
    public static var previewValue = Self.preview
}

struct RidesManager: Sendable {
    
    let dbContainer: ModelContainer
    
    static var live: RidesManager {
        let dbContainer: ModelContainer = try! ModelContainer(for: Ride.self, configurations: ModelConfiguration())
        return RidesManager(dbContainer: dbContainer)
    }
    
    static var preview: RidesManager {
        let dbContainer: ModelContainer = try! ModelContainer(for: Ride.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        return RidesManager(dbContainer: dbContainer)
    }
    
    func save(ride: Ride) async throws {
        let context = await dbContainer.mainContext
        context.insert(ride)
    }
    
    func getAllExisting() async throws -> [Ride] {
        let context = await dbContainer.mainContext
        return try! context.fetch(.init())
    }
}
