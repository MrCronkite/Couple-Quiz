//
//  ShimmerCTAButtonView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI


struct ShimmerCTAButton: View {
    let title: String
    @State private var shimmerOffset: CGFloat = -200

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.cGold, Color.cGold2],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            GeometryReader { geo in
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.25), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * 0.5)
                    .offset(x: shimmerOffset)
                    .clipped()
            }
            .clipped()

            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color(hex: "#1a0800"))
                .tracking(0.2)
        }
        .frame(height: 52)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.cGold2.opacity(0.35), radius: 16, y: 6)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 2.5)
                .repeatForever(autoreverses: false)
                .delay(0.5)
            ) {
                shimmerOffset = 500
            }
        }
    }
}
