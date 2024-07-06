//
//  RideDetailsScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI
import MapKit
import CoreLocation
import Charts

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
        .sheet(isPresented: .constant(true)) {
            VStack {
                HStack {
                    if let startTime = ride.startTime {
                        Spacer()
                        VStack {
                            Text("Ride start")
                                .font(.caption)
                            Text(startTime.formatted(date: .omitted, time: .shortened))
                                .font(.title)
                        }
                    }
                    if let endTime = ride.endTime {
                        Spacer()
                        VStack {
                            Text("Ride end")
                                .font(.caption)
                            Text(endTime.formatted(date: .omitted, time: .shortened))
                                .font(.title)
                        }
                        Spacer()
                    }
                }
                Chart {
                    ForEach(ride.points) { point in
                        LineMark(x: .value("Time", point.timestamp),
                                 y: .value("Altitude", point.altitude))
                    }
                }
            }
            .padding()
            .presentationBackgroundInteraction(.enabled(upThrough: .height(100.0)))
            .presentationDetents([.height(100.0), .medium])
            .interactiveDismissDisabled()
        }
    }
}

//#Preview {
//    let manager = RidesManager.preview
//    let ride = Ride(id: UUID(),
//                    points: [
//
//                    ])
//    return RideDetailsScreen(ride: ride)
//}
