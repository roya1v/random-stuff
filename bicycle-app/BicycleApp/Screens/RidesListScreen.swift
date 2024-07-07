//
//  RidesListScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import ComposableArchitecture

struct RidesListScreen: View {

    @Bindable var store: StoreOf<RidesListFeature>

    var body: some View {
        NavigationView {
            List(store.rides) { ride in
                NavigationLink {
                    RideDetailsScreen(ride: ride)
                } label: {
                    VStack {
                        Text("This is a trip from \(ride.startTime?.formatted(date: .omitted, time: .standard) ?? "") to \(ride.endTime?.formatted(date: .omitted, time: .standard) ?? "") on \(ride.startTime?.formatted(date: .numeric, time: .omitted) ?? "")")
                        HStack {
                            Image(systemName: "bicycle")
                            Text(ride.bicycle.name)
                        }
                    }
                }
            }
            .task {
                store.send(.appeared)
            }
        }
    }
}

#Preview {
    RidesListScreen(
        store: Store(
            initialState: RidesListFeature.State(),
            reducer: {
                RidesListFeature()
            }
        )
    )
}
