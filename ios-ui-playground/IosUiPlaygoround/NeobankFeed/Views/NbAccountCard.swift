//
//  NbAccountCard.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 13/03/2025.
//

import SwiftUI

struct NbAccountCard: View {
    var body: some View {
        VStack {
            Text("Osobiste PLN")
                .font(.nbFont1)
            Text("123")
                .font(.nbFont2) +
            Text(",89 zł")
                .font(.nbFont3)
            Button {

            } label: {
                Text("Konta")
                    .font(.system(size: 13.0))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 2.0)
                    .padding(12.0)
                    .background {
                        Capsule()
                            .foregroundStyle(
                                Color.nbGray
                            )
                    }

            }
        }
    }
}
