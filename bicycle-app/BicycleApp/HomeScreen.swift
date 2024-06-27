//
//  HomeScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 17/06/2024.
//

import SwiftUI
import MapKit
import SwiftData
import ComposableArchitecture

struct HomeScreen: View {

    let store: StoreOf<HomeFeature>

    var body: some View {
        ZStack(alignment: .bottom) {
            Map {
                UserAnnotation()
            }
            HStack {
                Button("Start trip") {
                    store.send(.startTapped)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!store.isStartEnabled)
                
                Button("Stop trip") {
                    store.send(.stopTapped)
                }
                .buttonStyle(.bordered)
                .disabled(!store.isStopEnabled)
            }
            .padding()
            .background(Color.white, in: .rect(cornerSize: .init(width: 16.0, height: 16.0)))
            .padding()
        }
    }
}

#Preview {
    let trackingThing = TrackingThing.preview
    return HomeScreen(store: Store(initialState: HomeFeature.State(), reducer: {
        HomeFeature(trackingThing: trackingThing)
    }))
        .environment(trackingThing)
}
