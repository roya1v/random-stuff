//
//  BicycleManager.swift
//  BicycleApp
//
//  Created by Mike S. on 03/07/2024.
//

import Foundation
import Dependencies
import SwiftData

extension DependencyValues {
    var bicycleManager: BicycleManager {
        get { self[BicycleManager.self] }
        set { self[BicycleManager.self] = newValue }
    }
}

extension BicycleManager: DependencyKey {
    public static var liveValue = Self()
    public static var previewValue = Self()
}

struct BicycleManager: Sendable {
    
    @Dependency(\.modelContainer) var dbContainer: ModelContainer
   
    @MainActor
    func save(bicycle: Bicycle) async throws {
        let context = dbContainer.mainContext
        context.insert(bicycle)
    }
    
    @MainActor
    func getAllExisting() async throws -> [Bicycle] {
        let context = dbContainer.mainContext
        return try! context.fetch(.init())
    }
}

