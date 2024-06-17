//
//  ContentView.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            HomeScreen()
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
}
