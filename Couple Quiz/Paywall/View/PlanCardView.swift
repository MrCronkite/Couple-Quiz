//
//  PlanCardView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI


struct PlanCard: View {
    let plan: PlanOption
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 2) {
                // Period label (extra top space if badge exists)
                Text(plan.period)
                    .font(.system(size: 8.5))
                    .foregroundColor(Color.cText2)
                    .padding(.top, plan.badge != nil ? 10 : 4)

                // Price
                Text(plan.price)
                    .font(.system(size: 17, weight: .bold, design: .serif))
                    .foregroundColor(isSelected ? Color.cGold : Color.cText)

                // Per label
                Text(plan.perLabel)
                    .font(.system(size: 8, weight: .light))
                    .foregroundColor(Color.cText3)

                // Saving badge
                if let saving = plan.saving {
                    Text(saving)
                        .font(.system(size: 7.5, weight: .semibold))
                        .foregroundColor(Color.cGreen)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 1)
                        .background(Color.cGreen.opacity(0.1))
                        .cornerRadius(4)
                        .padding(.top, 3)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            .background(
                isSelected
                    ? Color.cGold.opacity(0.05)
                    : Color.cSurface
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected ? Color.cGold : Color.white.opacity(0.07),
                        lineWidth: isSelected ? 1.5 : 1.5
                    )
            )
            .cornerRadius(16)
            .shadow(
                color: isSelected ? Color.cGold.opacity(0.08) : .clear,
                radius: 12, y: 4
            )

            // Top badge
            if let badge = plan.badge {
                Text(badge)
                    .font(.system(size: 7.5, weight: .bold))
                    .foregroundColor(Color(hex: "#1a0800"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        LinearGradient(
                            colors: [Color.cGold, Color.cGold2],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(6)
                    .shadow(color: Color.cGold2.opacity(0.3), radius: 4)
                    .offset(y: -9)
            }
        }
    }
}
