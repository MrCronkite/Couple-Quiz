//
//  PaywallModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct PlanOption: Identifiable {
    let id = UUID()
    let period: String
    let price: String
    let perLabel: String
    let badge: String?
    let saving: String?
}

struct FeatureItem: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
    let description: String
    let accentColor: Color
}
