//
//  TrackingThing.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import Foundation
import CoreLocation
import SwiftData
import Observation

@Observable
final class TrackingThing: NSObject {

    private let locationManager = CLLocationManager()
    private let dbContainer: ModelContainer

    private var currentRide: [CLLocation]?
    private var startTime: Date?
    
    init(configuration: ModelConfiguration) {
        dbContainer = try! ModelContainer(for: Ride.self, configurations: configuration)

        super.init()

        locationManager.delegate = self
    }

    static var preview: TrackingThing {
        TrackingThing(configuration: ModelConfiguration(isStoredInMemoryOnly: true))
    }


    func startRide() {
        if locationManager.authorizationStatus != .authorizedAlways && locationManager.authorizationStatus != .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
            return
        }

        currentRide = []
        startTime = Date.now
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    @MainActor
    func stopRide() {
        locationManager.stopUpdatingLocation()
        guard let currentRide else {
            print("Current ride was nil...")
            return
        }
        let points = currentRide
            .map { Ride.Point(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude, timestamp: $0.timestamp)}
        let ride = Ride(startTime: startTime!, endTime: Date.now,  points: points)
        let context = dbContainer.mainContext
        context.insert(ride)
    }

    @MainActor
    func getRides() -> [Ride] {
        let context = dbContainer.mainContext
        return try! context.fetch(.init())
    }
}

extension TrackingThing: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentRide?.append(locations.last!)
    }
}
