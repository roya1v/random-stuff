//
//  RideDetailsScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct RideDetailsScreen: View {
    
    let ride: Ride

    var coordinates: [CLLocationCoordinate2D] {
        ride.points
            .sorted(by: { $0.timestamp < $1.timestamp })
            .map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
    }

    var body: some View {
        Map {
            MapPolyline(coordinates: coordinates)
                .stroke(.blue, lineWidth: 2.0)
        }
    }
}

#Preview {
    let ride = Ride(id: UUID(), startTime: Date.now, endTime: Date.now, points: [])
    return RideDetailsScreen(ride: ride)
}
