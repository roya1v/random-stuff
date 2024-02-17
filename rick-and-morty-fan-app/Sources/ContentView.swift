//
//  ContentView.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            CharacterListScreen()
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
