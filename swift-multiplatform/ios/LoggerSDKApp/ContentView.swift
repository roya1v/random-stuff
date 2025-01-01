//
//  ContentView.swift
//  LoggerSDKApp
//
//  Created by Mike S. on 01/01/2025.
//

import SwiftUI
import DataLoggingSDK

let logger = DataLogger()

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Start") {
                logger.start()
            }
            Button("Stop") {
                logger.stop()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
