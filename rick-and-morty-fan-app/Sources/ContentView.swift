//
//  ContentView.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    let characterListStore = Store(initialState: CharacterListFeature.State()) {
        CharacterListFeature()
    }

    var body: some View {
        TabView {
            CharacterListView(store: characterListStore)
                .tabItem {
                    Label("Characters", systemImage: "person")
                }
            Text("Hello world!")
                .tabItem {
                    Label("Episodes", systemImage: "person")
                }
        }

    }
}

#Preview {
    ContentView()
}
