//
//  OnboardingView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct OnboardingView: View {

    @EnvironmentObject var router: AppRouter

    @State private var currentPage = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            emoji: "❤️",
            title: "Познай своего человека",
            subtitle: "100+ вопросов для пар. Узнайте друг друга глубже, чем думали.",
            primaryGradient: [
                Color(red: 0.65, green: 0.54, blue: 0.98),
                Color(red: 0.49, green: 0.23, blue: 0.93)
            ],
            glowColor: Color.purple,
            floatingEmojis: ["💫", "✨", "🌙"],
            cards: []
        ),

        OnboardingPage(
            emoji: "🎲",
            title: "Выберите тему — начните игру",
            subtitle: "7 тематик от романтики до смелых вопросов. Каждый раз что-то новое.",
            primaryGradient: [
                Color(red: 1.0, green: 0.42, blue: 0.42),
                Color(red: 1.0, green: 0.25, blue: 0.25)
            ],
            glowColor: Color.red,
            floatingEmojis: ["🔥", "💬", "🎯"],
            cards: [
                MiniCard(
                    emoji: "😊",
                    title: "Романтика",
                    color: Color.purple.opacity(0.25)
                ),
                MiniCard(
                    emoji: "🔥",
                    title: "Откровенно",
                    color: Color.red.opacity(0.25)
                ),
                MiniCard(
                    emoji: "🤣",
                    title: "Юмор",
                    color: Color.orange.opacity(0.25)
                )
            ]
        )
    ]

    var body: some View {
        ZStack {

            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.08),
                    Color(red: 0.08, green: 0.07, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
            .fill(pages[currentPage].glowColor.opacity(0.18))
            .frame(width: 420, height: 420)
            .blur(radius: 70)
            .offset(y: -150)

            VStack(spacing: 0) {

                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        OnboardingContentView(
                            page: page,
                            isLast: index == pages.count - 1,
                            currentPage: $currentPage
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                VStack(spacing: 24) {

                    PageIndicator(
                        currentPage: currentPage,
                        totalPages: pages.count
                    )
                    Button {
                        if currentPage < pages.count - 1 {
                            withAnimation(.spring()) {
                                currentPage += 1
                            }
                        } else {
                            router.showPaywall()
                        }
                    } label: {
                        Text(currentPage == pages.count - 1
                             ? "Начать игру"
                             : "Начать 💜")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .background(
                            LinearGradient(
                                colors: pages[currentPage].primaryGradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(
                            color: pages[currentPage]
                                .primaryGradient
                                .first?
                                .opacity(0.45) ?? .purple,
                            radius: 18,
                            y: 8
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 44)
                .padding(.top, 10)
                .background(.clear)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
