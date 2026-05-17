//
//  MiniCategoryCard.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct MiniCategoryCard: View {

    let card: MiniCard

    var body: some View {
        VStack(spacing: 8) {
            Text(card.emoji)
                .font(.system(size: 28))

            Text(card.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 92)
        .background(card.color)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.08))
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
