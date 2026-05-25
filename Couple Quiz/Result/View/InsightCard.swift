//
//  InsightCard.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 25.05.26.
//

import SwiftUI

struct InsightCard: View {
    let surprisedCount: Int

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text("💡")
                .font(.system(size: 20))

            Group {
                Text("\(surprisedCount) ответа тебя удивили. ")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                +
                Text("Это хороший знак — значит в ваших отношениях ещё есть что открывать.")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
            }
            .lineSpacing(4)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.mint.opacity(0.4))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
    }
}
