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

    @Bindable var store: StoreOf<HomeFeature>

    var body: some View {
        ZStack(alignment: .bottom) {
            Map {
                UserAnnotation()
            }
            VStack {
                if true {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Distance:")
                                .font(.caption)
                            Text("13.7km")
                                .font(.largeTitle)
                        }
                        Spacer()
                        VStack {
                            Text("Time:")
                                .font(.caption)
                            Text("\(store.secondsSinceStart)")
                                .font(.largeTitle)
                        }
                        Spacer()
                    }
                    .animation(.default, value: store.isStopEnabled)
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
                
            }
            .padding()
            .background(Color.white,
                        in: .rect(cornerSize: CGSize(width: 16.0, height: 16.0)))
            .padding()
        }
        .sheet(isPresented: $store
            .isShowingPermissionSheet
            .sending(\.isShowingPermissionSheetChanged)) {
                PermissionScreen(store: store)
            }
    }
}

#Preview {
    let trackingThing = TrackingThing.preview
    return HomeScreen(
        store: Store(
            initialState: HomeFeature.State(),
            reducer: {
                HomeFeature(trackingThing: trackingThing)
            }
        )
    )
    .environment(trackingThing)
}
