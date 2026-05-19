//
//  CategoryCardView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 19.05.26.
//

import SwiftUI


struct CategoryCard: View {

    let item: Category
    let isSelected: Bool
    let colors: [Color]

    var body: some View {

        ZStack(alignment: .leading) {

            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white.opacity(0.06))

            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.18)
            .clipShape(RoundedRectangle(cornerRadius: 22))

            VStack(alignment: .leading, spacing: 10) {

                HStack {
                    Text(item.emoji)
                        .font(.system(size: 40))

                    Spacer()

                    if item.isPremium {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.yellow)
                            .padding(8)
                            .background(Color.white.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }

             //   Spacer()

                VStack(alignment: .leading, spacing: 4) {

                    Text(item.name)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)

                    Text("\(item.questions.count) вопросов")
                        .font(.system(size: 15))
                        .foregroundColor(
                            item.isPremium ? .yellow : .gray
                        )
                }
                .frame(maxHeight: .infinity)
            }
            .padding(16)


        }
        .frame(height: 160)
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    isSelected
                    ? Color.purple.opacity(0.6)
                    : Color.white.opacity(0.06),
                    lineWidth: isSelected ? 2.5 : 1
                )
        }
    }
}
