//
//  RidesListFeature.swift
//  BicycleApp
//
//  Created by Mike S. on 06/07/2024.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation

@Reducer
struct RidesListFeature {
    @ObservableState
    struct State: Equatable {
        var rides = IdentifiedArrayOf<Ride>()
    }

    enum Action {
        case appeared
        case ristingRidesLoaded([Ride])
    }
    
    @Dependency(\.ridesManager) var ridesManager

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .appeared:
                return .run { send in
                    let rides = try! await ridesManager.getAllExisting()
                    await send(.ristingRidesLoaded(rides))
                }
            case .ristingRidesLoaded(let rides):
                state.rides = IdentifiedArray(uniqueElements: rides)
                return .none
            }
        }
    }
}
