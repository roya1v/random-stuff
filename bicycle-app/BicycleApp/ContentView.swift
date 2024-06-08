//
//  ContentView.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack {
                Button("Start trip") {
                    TrackingThing.shared.startRide()
                }
                Button("Stop trip") {
                    TrackingThing.shared.stopRide()
                }
                NavigationLink {
                    RidesListScreen()
                } label: {
                    Text("Rides list")
                }

            }
        }

    }
}

#Preview {
    ContentView()
}
