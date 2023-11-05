//
//  CardView.swift
//  FlashZilla
//
//  Created by Daniel Camarena on 10/28/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var isCorrect = false
    @State private var feedback =  UINotificationFeedbackGenerator()
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(differentiateWithoutColor 
                      ? .white
                      : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(getBackgroundColor())
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    if offset.width > 0{
                        isCorrect = true
                    }else if offset.width < 0 {
                        isCorrect = false
                    }
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        feedback.notificationOccurred(offset.width > 0 ? .success : .error)
                        removal?(!isCorrect)
                        if(!isCorrect){
                            isShowingAnswer = false
                            offset = .zero
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
    
    func getBackgroundColor() -> Color {
        if offset.width > 0 {
            return .green
        }
        
        if offset.width < 0 {
            return .red
        }
        
        return .white
    }
}

#Preview {
    CardView(card: Card.example)
}
