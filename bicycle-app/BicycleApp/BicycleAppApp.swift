//
//  BicycleAppApp.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import SwiftData

@main
struct BicycleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(TrackingThing(configuration: ModelConfiguration()))
        }
    }
}
