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
        var altitude: Double
        var timestamp: Date

        init(latitude: Double, longitude: Double, altitude: Double, timestamp: Date) {
            self.latitude = latitude
            self.longitude = longitude
            self.altitude = altitude
            self.timestamp = timestamp
        }
    }

    @Attribute(.unique) var id: UUID
    var points: [Point]
    
    var bicycle: Bicycle


    init(id: UUID = UUID(), points: [Point], bicycle: Bicycle) {
        self.id = id
        self.points = points
        self.bicycle = bicycle
    }
    
    var startTime: Date? {
        points.first?.timestamp
    }
    var endTime: Date? {
        points.last?.timestamp ?? points.first?.timestamp
    }
}

extension Ride {
//    static func forPreview() -> Ride {
//        let points = [
//            Point(latitude: 52.39531825080371, longitude: 20.938496748495204, altitude: 100.0, timestamp: Date(timeIntervalSince1970: 1719046943)),
//            Point(latitude: 52.395429546975116, longitude: 20.93870596078812, altitude: 101.0, timestamp: Date(timeIntervalSince1970: 1719046944)),
//            Point(latitude: 52.39556048328798, longitude: 20.938877622156667, altitude: 102.0, timestamp: Date(timeIntervalSince1970: 1719046945)),
//            Point(latitude: 52.39572415313275, longitude: 20.93916730071609, altitude: 103.0, timestamp: Date(timeIntervalSince1970: 1719046946)),
//            Point(latitude: 52.395989296993115, longitude: 20.939430157186678, altitude: 104.0, timestamp: Date(timeIntervalSince1970: 1719046947)),
//            Point(latitude: 52.3966865195632, longitude: 20.940336743849738, altitude: 105.0, timestamp: Date(timeIntervalSince1970: 1719046948)),
//            Point(latitude: 52.39726916658866, longitude: 20.941028753790825, altitude: 106.0, timestamp: Date(timeIntervalSince1970: 1719046949)),
//            Point(latitude: 52.39800237437111, longitude: 20.94191924714016, altitude: 107.0, timestamp: Date(timeIntervalSince1970: 1719046950)),
//            Point(latitude: 52.39774051584818, longitude: 20.9425307908284, altitude: 108.0, timestamp: Date(timeIntervalSince1970: 1719046951)),
//            Point(latitude: 52.39759976624956, longitude: 20.942761460792383, altitude: 109.0, timestamp: Date(timeIntervalSince1970: 1719046952)),
//            Point(latitude: 52.39743610336109, longitude: 20.94311014794724, altitude: 110.0, timestamp: Date(timeIntervalSince1970: 1719046953)),
//            Point(latitude: 52.396974570746096, longitude: 20.942562977335, altitude: 120.0, timestamp: Date(timeIntervalSince1970: 1719046954)),
//            Point(latitude: 52.39670615948769, longitude: 20.94220356134461, altitude: 130.0, timestamp: Date(timeIntervalSince1970: 1719046955)),
//            Point(latitude: 52.39636573308559, longitude: 20.9417583146379, altitude: 140.0, timestamp: Date(timeIntervalSince1970: 1719046956)),
//            Point(latitude: 52.396012210595245, longitude: 20.941554466749345, altitude: 150.0, timestamp: Date(timeIntervalSince1970: 17190469557))
//         ]
//        return Ride(points: points)
//    }
}
