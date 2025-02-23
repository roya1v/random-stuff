//
//  ContentView.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 07/02/2025.
//

import SwiftUI

struct ContentView: View {

    @State private var text = ""

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Shaky TextField") {
                    ShakyTextField(text: $text) {
                        text.contains(where: \.isLetter)
                    }
                    .padding()
                }
                NavigationLink("Fancy Onboarding") {
                    FancyOnboarding()
                }
                NavigationLink("Netflix Graphs") {
                    NetflixCharts()
                }
                NavigationLink("Draggable card") {
                    DraggableCard()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
