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
}

final class AppRouter: ObservableObject {


    @Published var route: AppRoute = .onboarding

    func showPaywall() {
        route = .paywall
    }

    func showMain() {
        route = .homePage
    }


}
