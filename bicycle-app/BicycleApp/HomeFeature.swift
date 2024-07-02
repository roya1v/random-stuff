//
//  HomeFeature.swift
//  BicycleApp
//
//  Created by Mike S. on 27/06/2024.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        struct Point: Equatable {
            let coordinate: CLLocationCoordinate2D
            let date: Date
            let alitude: Double
        }
        
        var secondsSinceStart = 0
        var isStartEnabled = true
        var isStopEnabled = false
        var isShowingPermissionSheet = false
        var points = [Point]()
        var rides = [Ride]()
    }

    enum Action {
        case appeared
        case startTapped
        case stopTapped
        case tripStopped
        case updateTime
        case isShowingPermissionSheetChanged(Bool)
        case requestPermissionTapped
        case locationManager(LocationManager.Action)
        case existingRidesLoaded([Ride])
        case finishedNewRide(Ride)
    }
    
    @Dependency(\.locationManager) var locationManager
    @Dependency(\.ridesManager) var ridesManager
    
    private let oldLocationManager = CLLocationManager()

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .appeared:
                return .run { send in
                    let rides = try! await ridesManager.getAllExisting()
                    await send(.existingRidesLoaded(rides))
                }
            case .existingRidesLoaded(let rides):
                state.rides = rides
                return .none
            case .finishedNewRide(let ride):
                state.rides.append(ride)
                return .none
            case .startTapped:
                guard oldLocationManager.authorizationStatus == .authorizedAlways || oldLocationManager.authorizationStatus == .authorizedWhenInUse else {
                    state.isShowingPermissionSheet = true
                    return .none
                }
                state.isStartEnabled = false
                state.isStopEnabled = true
                let clock = ContinuousClock()
                return .merge(
                    .run { send in
                        await locationManager.startUpdatingLocation()
                        await withTaskGroup(of: Void.self) { group in
                            group.addTask {
                                await withTaskCancellation(id: "test2", cancelInFlight: true) {
                                    for await action in await locationManager.delegate() {
                                        await send(.locationManager(action), animation: .default)
                                    }
                                }
                            }
                        }
                    },
                    .run { send in
                        while !Task.isCancelled {
                            do {
                                try await clock.sleep(for: .seconds(1))
                                await send(.updateTime)
                            } catch {
                                if !Task.isCancelled{fatalError()}
                            }
                        }
                    }.cancellable(id: "test",cancelInFlight: true)
                )
        
            case .stopTapped:
                state.isStopEnabled = false
                return .run { send in
                    await send(.tripStopped)
                }
            case .tripStopped:
                state.isStartEnabled = true
                
                return .merge(
                    .cancel(id: "test"),
                    .cancel(id: "test2"),
                    .run { [state] send in
                        let ride = Ride(startTime: Date.now,
                                        endTime: Date.now,
                                        points: state.points.map { Ride.Point(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude, altitude: $0.alitude, timestamp: $0.date)})
                        try? await ridesManager.save(ride: ride)
                        await send(.finishedNewRide(ride))
                    }
                )
            case .isShowingPermissionSheetChanged(let isShowing):
                state.isShowingPermissionSheet = isShowing
                return .none
            case .requestPermissionTapped:
                state.isShowingPermissionSheet = false
                oldLocationManager.requestAlwaysAuthorization()
                return .none
            case .updateTime:
                state.secondsSinceStart += 1
                return .none
            case .locationManager(.didUpdateLocations(let location)):
                if let coordinate = location.first {
                    state.points.append(State.Point(coordinate: coordinate.coordinate, date: Date.now, alitude: coordinate.altitude))
                }
                return .none
            case .locationManager(_):
                return .none
            }
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
