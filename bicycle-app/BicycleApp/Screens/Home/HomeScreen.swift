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
            ControlPanelView(store: store)
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
            }
        )
    )
}
