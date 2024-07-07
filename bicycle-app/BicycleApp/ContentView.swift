//
//  ContentView.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    var store: StoreOf<AppFeature>

    var body: some View {
        TabView {
            HomeScreen(store: store)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            RidesListScreen(store: store.scope(state: \.ridesList,
                                               action: \.ridesList))
                .tabItem {
                    Label("Rides", systemImage: "map")
                }
            BicycleScreen(store: store)
                .tabItem {
                    Label("Bicycles", systemImage: "bicycle")
                }
        }
        .task {
            store.send(.appeared)
        }
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: AppFeature.State(),
            reducer: {
                AppFeature()
                    .dependency(\.ridesManager, .previewValue)
            }
        )
    )
}
