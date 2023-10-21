//
//  Gestures.swift
//  FlashZilla
//
//  Created by Daniel Camarena on 10/21/23.
//

import SwiftUI

struct Gestures: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    @State private var currentAmountRotation = Angle.zero
    @State private var finalAmountRotation = Angle.zero
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false
    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = 
            DragGesture()
                .onChanged { value in offset = value.translation }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }
        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
        /*
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
            }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
            }
        )
         */
        /*
        VStack {
               Text("Hello, World!")
                   .onTapGesture {
                       print("Text tapped")
                   }
           }
           .highPriorityGesture(
               TapGesture()
                   .onEnded { _ in
                       print("VStack tapped")
                   }
           )
       }
         */
        /*
        VStack{
            Text("Double tap")
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
            
            Text("Long Press")
                .onLongPressGesture {
                    print("Long pressed!")
                }
            
            Text("Long Press 2 seconds")
                .onLongPressGesture(minimumDuration: 2) {
                    print("Long pressed!")
                }
            
            Text("Long Press 1 second")
                .onLongPressGesture(minimumDuration: 1) {
                    print("Long pressed!")
                } onPressingChanged: { inProgress in
                    print("In progress: \(inProgress)!")
                }
            
            Text("Magnification")
                .scaleEffect(finalAmount + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { amount in
                            currentAmount = amount - 1
                        }
                        .onEnded { amount in
                            finalAmount += currentAmount
                            currentAmount = 0
                        }
                )
            
            Text("Rotation")
                .rotationEffect(currentAmountRotation +  finalAmountRotation)
                .gesture(
                    RotationGesture()
                    .onChanged { angle in
                        currentAmountRotation = angle
                    }
                    .onEnded { angle in
                        finalAmountRotation += currentAmountRotation
                        currentAmountRotation = .zero
                    }
                )
        }
         */
    }
}

#Preview {
    Gestures()
}
