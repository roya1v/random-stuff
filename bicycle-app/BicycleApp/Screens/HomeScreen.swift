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

    @Bindable var store: StoreOf<AppFeature>

    var body: some View {
        ZStack(alignment: .bottom) {
            Map {
                UserAnnotation()
                MapPolyline(coordinates: store.points.map(\.coordinate))
                    .stroke(.blue, lineWidth: 2.0)
            }
            VStack {
                if true {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Distance:")
                                .font(.caption)
                            Text(store.distanceSinceStart.formatted(.measurement(width: .abbreviated, usage: .road)))
                                .font(.largeTitle)
                        }
                        Spacer()
                        VStack {
                            Text("Duration:")
                                .font(.caption)
                            Text(store.durationSinceStart.formatted())
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
    HomeScreen(
        store: Store(
            initialState: AppFeature.State(),
            reducer: {
                AppFeature()
                    .dependency(\.ridesManager, .previewValue)
            }
        )
    )
}
