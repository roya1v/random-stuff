//
//  Ride.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Ride {
    
    @Model
    class Point {
        var latitude: Double
        var longitude: Double
        var timestamp: Date

        init(latitude: Double, longitude: Double, timestamp: Date) {
            self.latitude = latitude
            self.longitude = longitude
            self.timestamp = timestamp
        }
    }

    @Attribute(.unique) var id: UUID
    var points: [Point]
    var startTime: Date
    var endTime: Date

    init(id: UUID = UUID(), startTime: Date, endTime: Date, points: [Point]) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.points = points
    }
}
