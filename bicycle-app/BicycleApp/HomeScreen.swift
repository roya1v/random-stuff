//
//  HomeScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 17/06/2024.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack {
            Text("Are you ready to ride?")
                .font(.largeTitle)
            Spacer()
            Button("Start trip") {
                TrackingThing.shared.startRide()
            }
            .buttonStyle(.borderedProminent)
            Button("Stop trip") {
                TrackingThing.shared.stopRide()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    HomeScreen()
}
