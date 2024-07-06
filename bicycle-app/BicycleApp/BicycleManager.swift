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
    
    func save(bicycle: Bicycle) async throws {
        let context = await dbContainer.mainContext
        context.insert(bicycle)
    }
    
    func getAllExisting() async throws -> [Bicycle] {
        let context = await dbContainer.mainContext
        return try! context.fetch(.init())
    }
}

