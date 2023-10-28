//
//  Accessibility.swift
//  FlashZilla
//
//  Created by Daniel Camarena on 10/28/23.
//

import SwiftUI

struct Accessibility: View {
    /*
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
     */
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    var body: some View {
        Text("Hello world")
            .scaleEffect(scale)
            .onTapGesture {
                if reduceMotion {
                    scale *= 1.5
                } else {
                    withAnimation {
                        scale *= 1.5
                    }
                }
            }
        /*
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
         */
    }
}

#Preview {
    Accessibility()
}
