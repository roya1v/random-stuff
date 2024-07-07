//
//  AppFeature.swift
//  BicycleApp
//
//  Created by Mike S. on 27/06/2024.
//

import Foundation
import ComposableArchitecture
import ComposableCoreLocation

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        struct Point: Equatable {
            let coordinate: CLLocationCoordinate2D
            let date: Date
            let alitude: Double
        }
        
        var distanceSinceStart = Measurement(value: 0.0, unit: UnitLength.meters)
        var durationSinceStart = Duration.seconds(0)
        var isStartEnabled = true
        var isStopEnabled = false
        var isShowingPermissionSheet = false
        var bicycle: Bicycle? = nil
        var points = [Location]()
        var bicycles = [Bicycle]()
        var ridesList = RidesListFeature.State()
    }

    enum Action {
        case appeared
        case startTapped
        case stopTapped
        case updateTime
        case isShowingPermissionSheetChanged(Bool)
        case requestPermissionTapped
        case locationManager(LocationManager.Action)
        case existingBicyclesLoaded([Bicycle])
        case selectedBicycle(Bicycle?)
        case newBicycleCreated(Bicycle)
        case newBicycleTapped(String)
        case finishedNewRide(Ride)
        case ridesList(RidesListFeature.Action)
    }
    
    enum CancelID { case timer, location }
    
    @Dependency(\.locationManager) var locationManager
    @Dependency(\.ridesManager) var ridesManager
    @Dependency(\.bicycleManager) var bicycleManager

    private let oldLocationManager = CLLocationManager()

    var body: some Reducer<State, Action> {
        Scope(state: \.ridesList, action: \.ridesList) {
            RidesListFeature()
        }
        Reduce { state, action in
            switch action {
            case .newBicycleTapped(let name):
                return .run { [name] send in
                    let bicycle = Bicycle(name: name)
                    try! await bicycleManager.save(bicycle: bicycle)
                    await send(.newBicycleCreated(bicycle))
                }
            case .newBicycleCreated(let newBicycle):
                state.bicycles.append(newBicycle)
                return .none
            case .selectedBicycle(let bicycle):
                state.bicycle = bicycle
                return .none
            case .appeared:
                return .run { send in
                    let bicycles = try! await bicycleManager.getAllExisting()
                    await send(.existingBicyclesLoaded(bicycles))
                }
            case .existingBicyclesLoaded(let bicycles):
                state.bicycles = bicycles
                return .none
            case .finishedNewRide(let ride):
                state.ridesList.rides.append(ride)
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
                                await withTaskCancellation(id: CancelID.location, cancelInFlight: true) {
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
                    }.cancellable(id: CancelID.timer,cancelInFlight: true)
                )
        
            case .stopTapped:
                state.isStopEnabled = false
                state.isStartEnabled = true
                
                return .merge(
                    .cancel(id: CancelID.timer),
                    .cancel(id: CancelID.location),
                    .run { [state] send in
                        let ride = Ride(points: state.points.map { Ride.Point(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude, altitude: $0.altitude, timestamp: $0.timestamp)}, bicycle: state.bicycle!)
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
                state.durationSinceStart += Duration.seconds(1)
                return .none
            case .locationManager(.didUpdateLocations(let location)):
                if let location = location.first {
                    if let previosLocation = state.points.last {
                        state.distanceSinceStart.value += location.rawValue.distance(from: previosLocation.rawValue)
                    }
                    
                    state.points.append(location)
                }
                return .none
            case .locationManager(_):
                return .none
            case .ridesList:
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
