//
//  BicycleAppApp.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct BicycleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: HomeFeature.State(),
                    reducer: {
                        HomeFeature()
                    }
                )
            )
        }
    }
}
