//
//  QuestionsViewModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 19.05.26.
//

import SwiftUI
import Combine

class QuizViewModel: ObservableObject {

    // Вопросы выбранной категории
    @Published var questions: [Question] = []

    // Текущий индекс
    @Published var currentIndex: Int = 0

    // Реакция на текущий вопрос
    @Published var selectedReaction: ReactionType?

    // Сохранённые результаты всех вопросов
    @Published var results: [ReactionType] = []

    // Показывать финальный экран
    @Published var isFinished: Bool = false

    // Текущий вопрос
    var currentQuestion: Question? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    // Прогресс 0.0 — 1.0
    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentIndex) / Double(questions.count)
    }

    // MARK: — Действия

    // Выбрать реакцию
    func selectReaction(_ reaction: ReactionType) {
        selectedReaction = reaction
    }

    // Следующий вопрос
    func nextQuestion() {
        guard let reaction = selectedReaction,
              let question = currentQuestion else { return }

        // Сохраняем результат
        results.append(reaction)

        // Сбрасываем реакцию
        selectedReaction = nil

        if currentIndex + 1 >= questions.count {
            // Все вопросы пройдены
            isFinished = true
        } else {
            currentIndex += 1
        }
    }

    // Пропустить вопрос (без реакции)
    func skipQuestion() {
        selectedReaction = nil
        if currentIndex + 1 >= questions.count {
            isFinished = true
        } else {
            currentIndex += 1
        }
    }

    // MARK: — Подсчёт результата

    // Количество каждого типа
    var knewCount: Int {
        results.filter { $0 == .knew }.count
    }

    var didntKnowCount: Int {
        results.filter { $0 == .didntKnow }.count
    }

    var surprisedCount: Int {
        results.filter { $0 == .surprised }.count
    }

    var totalAnswered: Int {
        results.count
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
