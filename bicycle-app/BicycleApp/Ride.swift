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

        init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }



    var points: [Point]

    init(points: [Point]) {
        self.points = points
    }
}
