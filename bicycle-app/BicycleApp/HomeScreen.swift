//
//  HomeScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 17/06/2024.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Button("Start trip") {
                    TrackingThing.shared.startRide()
                }
                Button("Stop trip") {
                    TrackingThing.shared.stopRide()
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
