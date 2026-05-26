//
//  OnboardingContentView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct OnboardingContentView: View {

    let page: OnboardingPage
    let isLast: Bool

    @Binding var currentPage: Int

    @State private var pulse = false

    var body: some View {
        ZStack {

            VStack(spacing: 0) {

                Spacer()
                    .frame(height: 70)

                ZStack {
                    ForEach(Array(page.floatingEmojis.enumerated()), id: \.offset) { index, emoji in
                        FloatingEmojiView(
                            emoji: emoji,
                            delay: Double(index) * 0.6,
                            xOffset: index == 0 ? -100 : index == 1 ? 90 : -70,
                            yOffset: index == 0 ? -30 : index == 1 ? 20 : 110
                        )
                    }

                    Text(page.emoji)
                        .font(.system(size: 58))
                        .scaleEffect(pulse ? 1.08 : 1)
                        .shadow(color: .pink.opacity(0.5), radius: 20)
                        .animation(
                            .easeInOut(duration: 2)
                            .repeatForever(),
                            value: pulse
                        )
                }

                Spacer()
                    .frame(height: 30)

                Text(page.title)
                    .font(
                        .system(size: 34, weight: .black, design: .serif)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, Color.purple.opacity(0.85)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Spacer()
                    .frame(height: 14)

                Text(page.subtitle)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.white.opacity(0.65))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.horizontal, 28)

                if !page.cards.isEmpty {
                    Spacer()
                        .frame(height: 26)

                    HStack(spacing: 10) {
                        ForEach(page.cards) { card in
                            MiniCategoryCard(card: card)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .onAppear {
            pulse = true
        }
    }
}
