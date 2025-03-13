//
//  NeobankFeedView.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 12/03/2025.
//

import SwiftUI

struct NeobankFeedView: View {

    @State var blur = 0.0

    var body: some View {
        ZStack {
            Color.nbBackground
                .ignoresSafeArea()
            VStack {
                NbNavigationBar()
                ScrollView {
                    NbAccountCard()
                        .frame(height: 320.0)
                    NbShortcuts()
                        .frame(width: .infinity)
                        .padding(.horizontal)
                    NbLastTransactions()
                        .padding(.horizontal)
                }

                .blur(radius: blur)
                .onScrollGeometryChange(for: CGFloat.self, of: \.contentOffset.y) { oldValue, newValue in
                    blur = newValue * -0.5
                }
            }
        }
        .brightness(Double(blur) * -0.01)
    }
}

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

#Preview {
    NeobankFeedView()
}
