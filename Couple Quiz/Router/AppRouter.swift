//
//  AppRouter.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI
import Combine

enum AppRoute {
    case onboarding
    case paywall
    case homePage
    case questions(Category)
    case result([ReactionType])
}

final class AppRouter: ObservableObject {

    @Published var route: AppRoute = .onboarding

    func showPaywall() {
        route = .paywall
    }

    func showMain() {
        route = .homePage
    }

    func showQuestions(_ category: Category) {
        route = .questions(category)
    }

    func showResult(_ reactions: [ReactionType]) {
        route = .result(reactions)
    }


}
