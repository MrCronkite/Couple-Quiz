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

