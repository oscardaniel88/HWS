//
//  DisablingInteractivity.swift
//  FlashZilla
//
//  Created by Daniel Camarena on 10/21/23.
//

import SwiftUI

struct DisablingInteractivity: View {
    var body: some View {
        /*
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
            
        }
         */
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

#Preview {
    DisablingInteractivity()
}
