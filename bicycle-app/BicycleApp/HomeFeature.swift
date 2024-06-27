//
//  HomeFeature.swift
//  BicycleApp
//
//  Created by Mike S. on 27/06/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        var isStartEnabled = true
        var isStopEnabled = false
    }

    enum Action {
        case startTapped
        case stopTapped
        case tripStopped
    }

    let trackingThing: TrackingThing

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .startTapped:
                trackingThing.startRide()
                state.isStartEnabled = false
                state.isStopEnabled = true
                return .none
            case .stopTapped:
                state.isStopEnabled = false
                return .run { send in
                    await trackingThing.stopRide()
                    await send(.tripStopped)
                }
            case .tripStopped:
                state.isStartEnabled = true
                return .none
            }
        }
    }
}
