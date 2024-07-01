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
        var isShowingPermissionSheet = false
    }

    enum Action {
        case startTapped
        case stopTapped
        case tripStopped
        case isShowingPermissionSheetChanged(Bool)
        case requestPermissionTapped
    }

    let trackingThing: TrackingThing

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .startTapped:
                guard trackingThing.hasPermission() else {
                    state.isShowingPermissionSheet = true
                    return .none
                }
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
            case .isShowingPermissionSheetChanged(let isShowing):
                state.isShowingPermissionSheet = isShowing
                return .none
            case .requestPermissionTapped:
                state.isShowingPermissionSheet = false
                trackingThing.requestPermission()
                return .none
            }
        }
    }
}
