//
//  RidesListScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct RidesListScreen: View {

    @Bindable var store: StoreOf<AppFeature>

    var body: some View {
        NavigationView {
            List(store.rides) { ride in
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
    RidesListScreen(
        store: Store(
            initialState: AppFeature.State(),
            reducer: {
                AppFeature()
                    .dependency(\.ridesManager, .previewValue)
            }
        )
    )
}
