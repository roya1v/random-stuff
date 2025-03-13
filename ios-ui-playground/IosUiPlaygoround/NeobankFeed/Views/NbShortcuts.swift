//
//  NbShortcuts.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 13/03/2025.
//

import SwiftUI

struct NbShortcuts: View {
    var body: some View {
        HStack {
            button(title: "Wpłać", systemIcon: "plus")
            button(title: "BLIK", systemIcon: "plus")
            button(title: "Przenieś", systemIcon: "plus")
            button(title: "Więcej", systemIcon: "plus")
        }
    }

    func button(title: String, systemIcon: String) -> some View {
        Button {

        } label: {
            VStack {
                Image(systemName: systemIcon)
                    .foregroundStyle(.black)
                    .padding(16.0)
                    .background {
                        Circle()
                            .foregroundStyle(
                                Color.nbGray
                            )

                    }
                Text(title)
                    .font(.nbFont1)
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}
