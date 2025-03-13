//
//  NeobankFeedView.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 12/03/2025.
//

import SwiftUI

struct NeobankFeedView: View {

    @State var blur = 0.0 // 32.0
    @State var darkness = 0.0 // 0.8

    @State var isShowing = true

    var body: some View {
        ZStack {
            ZStack {
                Color.nbBackground
                    .ignoresSafeArea()
                VStack {
                    NbNavigationBar()
                        .blur(radius: isShowing ? 32.0 : blur)
                    ScrollView {
                        NbAccountCard()
                            .frame(height: 320.0)
                        NbShortcuts()
                            .frame(width: .infinity)
                            .padding(.horizontal)
                        NbLastTransactions()
                            .padding(.horizontal)
                    }
                    .blur(radius: isShowing ? 32.0 : blur)

                    .onScrollGeometryChange(for: CGFloat.self, of: \.contentOffset.y) { oldValue, newValue in
                        blur = 6 * newValue / -62
                        blur = min(blur, 6)

                        darkness = 0.25 * newValue / -62
                        darkness = min(darkness, 0.25)
                    }
                    .onScrollPhaseChange { oldPhase, newPhase in
                        switch newPhase {
                        case .idle:
                            print("animating")
                        case .tracking:
                            print("animating")
                        case .interacting:
                            print("animating")
                        case .decelerating:
                            if darkness == 0.25 {
                                withAnimation {
                                    isShowing = true
                                }
                            }
                        case .animating:
                            print("animating")
                        }
                    }
                }

            }
            .brightness(isShowing ? -0.6 : -darkness)

            if isShowing {
                NbAccountsList {
                    withAnimation {
                        isShowing = false
                    }
                }
            }
        }
    }
}

#Preview {
    NeobankFeedView()
}
