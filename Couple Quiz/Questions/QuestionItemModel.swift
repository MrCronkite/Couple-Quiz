//
//  QuestionItemModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 19.05.26.
//

import SwiftUI


enum ReactionType: CaseIterable {

    case knew
    case didntKnow
    case surprised

    var emoji: String {

        switch self {
        case .knew:
            return "😌"

        case .didntKnow:
            return "🤯"

        case .surprised:
            return "😳"
        }
    }

    var title: String {

        switch self {
        case .knew:
            return "Знал"

        case .didntKnow:
            return "Не знал"

        case .surprised:
            return "Удивил"
        }
    }

    static var randomEmoji: String {
        [
            "😀", "🔥", "💜", "🚀", "✨",
            "🎯", "🌈", "🍕", "🎵", "🐶",
            "🦋", "🍓", "⚡️", "🌙", "💎",
            "🎮", "📚", "☀️", "🎉", "🫶"
        ].randomElement() ?? "🙂"
    }
}
