//
//  HomeModel.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI

//struct CategoryItem: Identifiable {
//
//    let id = UUID()
//
//    let emoji: String
//    let title: String
//    let subtitle: String
//    let colors: [Color]
//
//    let isPremium: Bool
//}

struct QuizData: Decodable {
    let version: String
    let categories: [Category]
}

struct Category: Decodable {
    let id: String
    let name: String
    let emoji: String
    let isPremium: Bool
    let questions: [Question]
}

struct Question: Decodable {
    let id: String
    let text: String
}


