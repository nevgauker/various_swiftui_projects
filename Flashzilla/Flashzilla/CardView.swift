//
//  CardView.swift
//  Flashzilla
//
//  Created by Rotem Nevgauker on 28/11/2023.
//

import SwiftUI

extension Shape {
    func fill(using offset: CGSize) -> some View {
        if offset.width == 0 {
            return self.fill(.white)
        } else if offset.width < 0 {
            return self.fill(.red)
        } else {
            return self.fill(.green)
        }
    }
}

struct CardView: View {
    let card: Card
//    var removal: (() -> Void)? = nil
    var removal: ((Bool) -> Void)? = nil

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var feedback = UINotificationFeedbackGenerator()


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                    
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(using: offset)
//                        .fill(offset.width > 0 ? .green : .red)
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
                }            }
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
                    feedback.prepare()
                }
                .onEnded { _ in
                    
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                            removal?(false)
                        } else {
                            feedback.notificationOccurred(.error)
                            removal?(true)
                            offset = .zero
                        }
                    } else {
                        offset = .zero
                    }
                    
                    
//                    if abs(offset.width) > 100 {
//                        removal?()
//                    } else {
//                        offset = .zero
//                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)

    }
}

#Preview {
    CardView(card: Card.example)
}
