//
//  TrialPill.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI

struct TrialPill: View {
    @State private var dotScale: CGFloat = 1
    @State private var dotOpacity: Double = 1

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Color.cGold)
                .frame(width: 6, height: 6)
                .shadow(color: Color.cGold.opacity(0.8), radius: 3)
                .scaleEffect(dotScale)
                .opacity(dotOpacity)

            Text("3 дня бесплатно, затем по выбранному тарифу")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.cGold)
                .tracking(0.3)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(Color.cGold.opacity(0.07))
        .overlay(
            Capsule().stroke(Color.cGold.opacity(0.2), lineWidth: 1)
        )
        .clipShape(Capsule())
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                dotScale = 0.7
                dotOpacity = 0.4
            }
        }
    }
}
