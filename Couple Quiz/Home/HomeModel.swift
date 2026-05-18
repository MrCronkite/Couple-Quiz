//
//  HomeModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI

struct CategoryItem: Identifiable {

    let id = UUID()

    let emoji: String
    let title: String
    let subtitle: String
    let colors: [Color]

    let isPremium: Bool
    let isSelected: Bool
}
