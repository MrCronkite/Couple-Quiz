//
//  FloatingEmojiView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct FloatingEmojiView: View {

    let emoji: String
    let delay: Double
    let xOffset: CGFloat
    let yOffset: CGFloat

    @State private var floating = false

    var body: some View {
        Text(emoji)
            .font(.system(size: 22))
            .opacity(0.3)
            .offset(
                x: xOffset,
                y: floating ? yOffset - 10 : yOffset + 10
            )
            .rotationEffect(.degrees(floating ? 4 : -4))
            .animation(
                .easeInOut(duration: 3)
                .repeatForever()
                .delay(delay),
                value: floating
            )
            .onAppear {
                floating = true
            }
    }
}
