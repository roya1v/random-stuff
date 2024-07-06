//
//  BicycleScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 06/07/2024.
//

import SwiftUI
import ComposableArchitecture

struct BicycleScreen: View {
    
    @Bindable var store: StoreOf<AppFeature>
    
    @State var newBicycleName = ""
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            List(store.bicycles) { bicycle in
                Text(bicycle.name)
            }
            .alert("Create a new bicycle", isPresented: $isShowingAlert) {
                TextField("Enter your bicycle name", text: $newBicycleName)
                Button("OK") {
                    store.send(.newBicycleTapped(newBicycleName))
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("New bicycle name")
            }
            .toolbar {
                Button("New") {
                    isShowingAlert = true
                }
            }
        }
    }
}

#Preview {
    BicycleScreen(
        store: Store(
            initialState: AppFeature.State(),
            reducer: {
                AppFeature()
            }
        )
    )
}
