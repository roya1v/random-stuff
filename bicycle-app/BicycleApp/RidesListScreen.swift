//
//  RidesListScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI

struct RidesListScreen: View {

    @Environment(TrackingThing.self) private var thing

    var body: some View {
        NavigationView {
            List(thing.getRides()) { ride in
                NavigationLink {
                    RideDetailsScreen(ride: ride)
                } label: {
                    Text("This is a trip from \(ride.startTime.formatted(date: .omitted, time: .standard)) to \(ride.endTime.formatted(date: .omitted, time: .standard)) on \(ride.startTime.formatted(date: .numeric, time: .omitted))")
                }
            }
        }
    }
}

#Preview {
    RidesListScreen()
        .environment(TrackingThing.preview)
}
