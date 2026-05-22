//
//  QuestionsViewModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 19.05.26.
//

import SwiftUI
import Combine

class QuestionsViewModel: ObservableObject {

    @Published var category: Category

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

    init(category: Category) {
        self.category = category

        questions = category.questions
    }

    // MARK: — Действия

    // Выбрать реакцию
    func selectReaction(_ reaction: ReactionType) {
        selectedReaction = reaction
    }

    // Следующий вопрос
    func nextQuestion() {
        guard let reaction = selectedReaction else { return }

        // Сохраняем результат
        results.append(reaction)

        // Сбрасываем реакцию
        selectedReaction = nil

        if currentIndex + 1 >= questions.count {
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

   
}
