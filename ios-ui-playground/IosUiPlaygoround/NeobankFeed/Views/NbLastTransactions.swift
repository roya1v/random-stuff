//
//  NbLastTransactions.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 13/03/2025.
//

import SwiftUI

struct NbLastTransactions: View {
    var body: some View {
        VStack {
            row()
            row()
            row()
        }
        .background {
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundStyle(Color.nbWhite)
        }
    }

    func row() -> some View {
        HStack {
            Image(systemName: "cart")
            VStack(alignment: .leading) {
                HStack {
                    Text("Supermarket")
                    Spacer()
                    Text("-12,34 zł")
                }
                Text("Dzisiaj, 12:34")
                    .font(.nbFont1)
                    .foregroundStyle(Color(red: 79 / 255, green: 77 / 255, blue: 80 / 255))
            }
        }
        .padding()
    }
}
