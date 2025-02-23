//
//  DraggableCardView.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 23/02/2025.
//

import SwiftUI

struct DraggableCard: View {

    @State var position = CGSize(width: 0, height: 0)

    var body: some View {
        GeometryReader { proxy in
            Text("😳")

                .frame(width: 80.0, height: 80.0)
                .background {
                    RoundedRectangle(cornerRadius: 8.0)
                        .shadow(radius: 8.0)
                        .foregroundStyle(.white)
                }
                .coordinateSpace(.named("container"))
                .offset(position)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            position = CGSize(
                                width: value.location.x - 40.0,
                                height: value.location.y - 40.0
                            )
                        }
                        .onEnded { value in
                            let width = proxy.size.width
                            let height = proxy.size.height
                            let x = position.width
                            let y = position.height

                            let closeToTop = y < height / 2.0
                            let closeToLeading = x < width / 2.0

                            let destination = switch (closeToTop, closeToLeading) {
                            case (true, true):
                                CGSize(
                                    width: 0,
                                    height: 0
                                )
                            case (true, false):
                                CGSize(
                                    width: width - 80.0,
                                    height: 0
                                )
                            case (false, true):
                                CGSize(
                                    width: 0,
                                    height: height - 80.0
                                )
                            case (false, false):
                                CGSize(
                                    width: width - 80.0,
                                    height: height - 80.0
                                )
                            }
                            withAnimation {
                                position = destination
                            }
                        }
                )
        }
    }
}

#Preview {
    DraggableCard()
}
