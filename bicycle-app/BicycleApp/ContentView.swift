//
//  ContentView.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    var store: StoreOf<HomeFeature>

    var body: some View {
        TabView {
            HomeScreen(store: store)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            RidesListScreen(store: store)
                .tabItem {
                    Label("Rides", systemImage: "bicycle")
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
            initialState: HomeFeature.State(),
            reducer: {
                HomeFeature()
                    .dependency(\.ridesManager, .previewValue)
            }
        )
    )
}
