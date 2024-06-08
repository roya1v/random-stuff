//
//  TrackingThing.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import Foundation
import CoreLocation
import SwiftData

final class TrackingThing: NSObject {

    static let shared = TrackingThing()
    override init() {
        super.init()

        locationManager.delegate = self
    }

    private let locationManager = CLLocationManager()
    private let dbContainer = try! ModelContainer(for: Ride.self, configurations: ModelConfiguration())

    private var currentRide: [CLLocation]?

    func startRide() {
        if locationManager.authorizationStatus != .authorizedAlways && locationManager.authorizationStatus != .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }

        currentRide = []
        locationManager.startUpdatingLocation()
    }

    func stopRide() {
        locationManager.stopUpdatingLocation()
        guard let currentRide else {
            print("Current ride was nil...")
            return
        }
        let ride = Ride(points: currentRide.map { Ride.Point(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)})
        Task {
            let context = await dbContainer.mainContext
            context.insert(ride)
        }
    }

    @MainActor
    func getRides() -> [Ride] {
        let context = dbContainer.mainContext
        return try! context.fetch(.init())
    }
}

extension TrackingThing: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentRide?.append(locations.first!)
    }
}
