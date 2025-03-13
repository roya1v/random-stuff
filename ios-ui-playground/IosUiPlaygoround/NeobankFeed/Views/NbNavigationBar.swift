//
//  NbNavigationBar.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 13/03/2025.
//

import SwiftUI

struct NbNavigationBar: View {
    var body: some View {
        HStack(spacing: 4.0) {
            Circle()
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Szukaj")
                    .font(.nbFont1)
                Spacer()
            }
            .padding(8.0)
            .background {
                Capsule()
                    .foregroundStyle(
                        Color.nbGray
                    )
            }
            Button {

            } label: {
                Image(systemName: "chart.bar.fill")
                    .foregroundStyle(.black)
                    .padding(8.0)
                    .background {
                        Circle()
                            .foregroundStyle(
                                Color.nbGray
                            )
                    }
            }
            Button {

            } label: {
                Image(systemName: "creditcard.fill")
                    .foregroundStyle(.black)
                    .padding(8.0)
                    .background {
                        Circle()
                            .foregroundStyle(
                                Color.nbGray
                            )
                    }

            }
        }
        .frame(height: 42.0)
        .padding(.horizontal, 12.0)
    }
}
