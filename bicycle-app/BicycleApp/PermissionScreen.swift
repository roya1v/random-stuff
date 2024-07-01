//
//  PermissionScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 01/07/2024.
//

import SwiftUI
import ComposableArchitecture

struct PermissionScreen: View {
    
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        VStack(alignment: .center) {
            Text("We need access to your location!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("In order to track your rides the app neeeds access to your location.")
                .multilineTextAlignment(.center)
                .padding()
                
            Spacer()
            Button {
                store.send(.requestPermissionTapped)
            } label: {
                Text("Request permission")
                    .padding([.all], 8.0)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    let trackingThing = TrackingThing.preview
    return PermissionScreen(
        store: Store(
            initialState: HomeFeature.State(),
            reducer: {
                HomeFeature(trackingThing: trackingThing)
            }
        )
    )
    .environment(trackingThing)
}
