//
//  HomeViewModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 19.05.26.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {

    @Published var categories: [Category] = []

    init() {
        loadCategories()
    }

    func loadCategories() {
        guard let data = loadQuiz() else { return }
        categories = data.categories
    }

    func loadQuiz() -> QuizData? {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json")
        else {
            print("JSON not found")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = try JSONDecoder().decode(QuizData.self, from: data)
            return decoder
        } catch {
            print("Decoding error:", error)
            return nil
        }
    }
}
