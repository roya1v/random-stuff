//
//  ContentView.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    @Environment(TrackingThing.self) private var trackingThing

    var body: some View {
        TabView {
            HomeScreen(store: Store(initialState: HomeFeature.State(), reducer: {
                HomeFeature(trackingThing: trackingThing)
            }))
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            RidesListScreen()
                .tabItem {
                    Label("Rides", systemImage: "bicycle")
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(TrackingThing.preview)
}
