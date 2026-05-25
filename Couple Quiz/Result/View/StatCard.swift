//
//  StatCard.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 25.05.26.
//

import SwiftUI


struct StatCard: View {

    let emoji: String
    let value: Int
    let label: String
    let valueColor: Color
    let topColor: [Color]

    var body: some View {

        ZStack(alignment: .top) {

            RoundedRectangle(cornerRadius: 16)
                .fill(valueColor)

            VStack(spacing: 5) {

                Text(emoji)
                    .font(.system(size: 20))

                Text("\(value)")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)

                Text(label)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.vertical, 14)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.07), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
