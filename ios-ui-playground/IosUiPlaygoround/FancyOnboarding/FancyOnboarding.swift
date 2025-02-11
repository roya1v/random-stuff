//
//  FancyOnboarding.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 11/02/2025.
//

import SwiftUI

struct OnboardingPage {
    let title: String
    let systemImage: String
    let content: String
    let color: Color

    static let preview = [
        OnboardingPage(
            title: "Onboard and onboard",
            systemImage: "chart.line.text.clipboard",
            content: "Onboard and start to onboard in the onboard",
            color: .orange
        ),
        OnboardingPage(
            title: "Onboard and onboard2",
            systemImage: "figure.run.treadmill.circle",
            content: "Onboard and start to onboard in the onboard",
            color: .green
        ),
        OnboardingPage(
            title: "Onboard and onboard3",
            systemImage: "sun.righthalf.filled",
            content: "Onboard and start to onboard in the onboard",
            color: .purple
        ),
        OnboardingPage(
            title: "Onboard and onboard4",
            systemImage: "rectangle.grid.3x3",
            content: "Onboard and start to onboard in the onboard",
            color: .blue
        )
    ]
}

struct PageIndicator: View {

    @Binding var page: Int
    var color: Color
    var numberOfPages: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .foregroundStyle(.regularMaterial)
            .frame(width: CGFloat(numberOfPages) * 20.0 + 12.0, height: 32.0)
            .overlay {
                HStack {
                    ForEach(0..<numberOfPages, id: \.self) { index in
                        Circle()
                            .foregroundStyle( index == page ? color : .gray)
                            .frame(width: 8.0, height: 8.0)
                    }
                }
            }
    }
}

struct FancyOnboarding: View {

    @State var selection = 0

    var body: some View {
        VStack {
            Text("Fancy Onboarding")
                .font(.title)
            TabView(selection: $selection) {
                ForEach(Array(OnboardingPage.preview.enumerated()), id: \.offset) { page in
                    VStack(alignment: .leading) {
                        Image(systemName: page.element.systemImage)
                            .resizable()
                            .scaledToFit()
                            .padding(64.0)
                            .fontWeight(.ultraLight)
                        Text(page.element.title)
                            .font(.largeTitle)
                        Text(page.element.content)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding(32.0)
                    .tag(page.offset)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack {
                PageIndicator(page: $selection,
                              color: OnboardingPage.preview[selection].color,
                              numberOfPages: OnboardingPage.preview.count)
                Spacer()
                Button {
                    if selection >= OnboardingPage.preview.count - 1 {
                        selection = 0
                    } else {
                        selection += 1
                    }
                } label: {
                    Circle()
                        .foregroundStyle(OnboardingPage.preview[selection].color)
                        .frame(width: 60.0, height: 60.0)
                        .overlay {
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.white)
                        }
                }
            }
            .padding(.horizontal, 32.0)
        }
        .background(OnboardingPage.preview[selection].color.opacity(0.4))
        .animation(.default, value: selection)
    }
}

#Preview {
    FancyOnboarding()
}
