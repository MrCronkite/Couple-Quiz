//
//  MatchResultViewModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 22.05.26.
//

import SwiftUI
import Combine


final class MatchResultViewModel: ObservableObject {

    @Published var reactions: [ReactionType] = []

    init(reactions: [ReactionType]) {
        self.reactions = reactions
    }

    // MARK: — Подсчёт результата

    // Количество каждого типа
    var knewCount: Int {
        reactions.filter { $0 == .knew }.count
    }

    var didntKnowCount: Int {
        reactions.filter { $0 == .didntKnow }.count
    }

    var surprisedCount: Int {
        reactions.filter { $0 == .surprised }.count
    }

    var totalAnswered: Int {
        reactions.count
    }

    // Процент совместимости
    // "Знал" = 100%, "Удивил" = 50%, "Не знал" = 0%
    var compatibilityPercent: Int {
        guard totalAnswered > 0 else { return 0 }

        let score = (knewCount * 100) + (surprisedCount * 50) + (didntKnowCount * 0)
        let maxScore = totalAnswered * 100

        return Int(Double(score) / Double(maxScore) * 100)
    }

    // Текст по проценту
    var resultTitle: String {
        switch compatibilityPercent {
        case 85...100: return "Вы читаете мысли друг друга 🔮"
        case 70...84:  return "Вы отлично знаете друг друга 💜"
        case 55...69:  return "Вы хорошо знакомы, но секреты есть 😊"
        case 40...54:  return "Ещё есть что открыть друг в друге 🌱"
        case 20...39:  return "Впереди много интересных открытий 🗺️"
        default:       return "Вы только начинаете узнавать друг друга ✨"
        }
    }

    // Подзаголовок
    var resultSubtitle: String {
        switch compatibilityPercent {
        case 85...100:
            return "Из \(totalAnswered) вопросов ты угадал \(knewCount). Это настоящая связь!"
        case 70...84:
            return "Ты хорошо её знаешь. \(surprisedCount) ответов тебя приятно удивили."
        case 55...69:
            return "\(knewCount) угадал, \(surprisedCount) удивили. Есть что обсудить вечером 😄"
        case 40...54:
            return "Целых \(didntKnowCount) новых фактов о ней! Отношения становятся глубже."
        default:
            return "Не расстраивайся — \(didntKnowCount) новых открытий это только начало."
        }
    }

    // Эмодзи для результата
    var resultEmoji: String {
        switch compatibilityPercent {
        case 85...100: return "🔮"
        case 70...84:  return "💜"
        case 55...69:  return "😊"
        case 40...54:  return "🌱"
        default:       return "✨"
        }
    }
}
