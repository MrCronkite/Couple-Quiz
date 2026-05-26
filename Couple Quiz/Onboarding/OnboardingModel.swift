//
//  OnboardingModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let subtitle: String
    let primaryGradient: [Color]
    let glowColor: Color
    let floatingEmojis: [String]
    let cards: [MiniCard]
}

struct MiniCard: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let color: Color
}

extension OnboardingPage {

    static var pages: [OnboardingPage] = [
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
}

