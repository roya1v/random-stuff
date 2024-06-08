//
//  RidesListScreen.swift
//  BicycleApp
//
//  Created by Mike S. on 08/06/2024.
//

import SwiftUI

struct RidesListScreen: View {
    var body: some View {
        List(TrackingThing.shared.getRides()) { ride in
            Text("\(ride.points.count)")
        }
    }
}

#Preview {
    RidesListScreen()
}
