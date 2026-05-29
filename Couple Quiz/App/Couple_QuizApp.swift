//
//  Couple_QuizApp.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

@main
struct Couple_QuizApp: App {

    @StateObject private var router = AppRouter()
    private let pm: PurchaseManager

    init() {
        pm = PurchaseManagerImpl()
        pm.completeTransactions()
    }

    var body: some Scene {

        WindowGroup {
            switch router.route {
            case .paywall:
                PaywallView()
                    .environmentObject(router)
            case .homePage:
                HomeView()
                    .environmentObject(router)
            case .onboarding:
            OnboardingView()
                    .environmentObject(router)
            case .questions(let category):
                QuestionsView(category: category)
                    .environmentObject(router)
            case .result(let reactions):
                MatchResultView(reactions: reactions)
                    .environmentObject(router)
            }
        }
    }
}
