//
//  ShakyTextField.swift
//  IosUiPlaygoround
//
//  Created by Mike S. on 07/02/2025.
//

import SwiftUI

struct ShakyTextField: View {

    @State private var isShaking = false

    @Binding var text: String
    let onSubmit: (() -> Bool)?

    var body: some View {
        TextField("Shaky", text: $text)
            .textFieldStyle(.roundedBorder)
            .onSubmit {
                isShaking = !(onSubmit?() ?? true)
            }
            .keyframeAnimator(initialValue: 0.0, trigger: isShaking) { content, value in
                content
                    .offset(x: value)
            } keyframes: { value in
                CubicKeyframe(10.0, duration: 0.1)
                CubicKeyframe(-10.0, duration: 0.1)
                CubicKeyframe(10.0, duration: 0.1)
                CubicKeyframe(-10.0, duration: 0.1)
                CubicKeyframe(0.0, duration: 0.1)
            }
    }
}

#Preview {
    @Previewable @State var text = "Preview"
    ShakyTextField(text: $text) {
        text.contains(where: \.isLetter)
    }
    .padding()
}
