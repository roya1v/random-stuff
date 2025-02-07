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
                NavigationLink("ShakyTextField") {
                    ShakyTextField(text: $text) {
                        text.contains(where: \.isLetter)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
