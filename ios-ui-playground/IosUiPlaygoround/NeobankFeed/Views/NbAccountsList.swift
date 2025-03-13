//
//  NbAccountsList.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 13/03/2025.
//

import SwiftUI

struct NbAccountsList: View {

    let onClose: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        onClose()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    Spacer()

                }
                .padding(.bottom, 24.0)

                HStack {
                    Text("Ulubione")
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 12.0)
                        .opacity(0.8)
                }

                VStack {
                    row()
                    row()
                    row()
                }
                .background {
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(Color.white.opacity(0.1))
                }
                Text("Osobiste")
                VStack {
                    row()
                    row()
                    row()
                }
                .background {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundStyle(Color.white.opacity(0.1))
                }
            }
            .padding()

            .foregroundStyle(.white)
        }
    }

    func row() -> some View {
        HStack {
            Image(systemName: "wallet.bifold.fill")
                .padding(12.0)
                .background {
                    Circle()
                        .foregroundStyle(.purple)
                }
            VStack(alignment: .leading) {
                HStack {
                    Text("Supermarket")
                    Spacer()
                    Text("-12,34 zł")
                }
                Text("Dzisiaj, 12:34")
                    .font(.nbFont1)
                    .foregroundStyle(.white)
            }
        }
        .padding(12.0)
    }
}
