//
//  HomeScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 17/06/2024.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {

    @Environment(TrackingThing.self) private var thing

    var body: some View {
        VStack {
            Text("Are you ready to ride?")
                .font(.largeTitle)
            Spacer()
            Button("Start trip") {
                thing.startRide()
            }
            .buttonStyle(.borderedProminent)
            Button("Stop trip") {
                thing.stopRide()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    HomeScreen()
        .environment(TrackingThing.preview)
}
