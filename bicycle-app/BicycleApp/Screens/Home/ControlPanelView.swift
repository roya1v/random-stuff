//
//  ControlPanelView.swift
//  BicycleApp
//
//  Created by Mike S. on 09/07/2024.
//

import SwiftUI
import ComposableArchitecture

struct ControlPanelView: View {
    
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        VStack {
            if store.isStopEnabled {
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
            }
            Picker("Bicycle",
                   selection: $store.bicycle.sending(\.selectedBicycle)) {
                ForEach(store.bicycles) { bicycle in
                    Text(bicycle.name)
                        .tag(bicycle as Bicycle?)
                }
                Text("None")
                    .tag(nil as Bicycle?)
            }
                   .pickerStyle(.menu)
            HStack {
                Button("Start trip") {
                    store.send(.startTapped, animation: .easeInOut)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!store.isStartEnabled)
                
                Button("Stop trip") {
                    store.send(.stopTapped, animation: .easeInOut)
                }
                .buttonStyle(.bordered)
                .disabled(!store.isStopEnabled)
            }
            
        }
        .padding()
        .background(Color.white,
                    in: .rect(cornerSize: CGSize(width: 16.0, height: 16.0)))
    }
}
