//
//  OrbitingCrownView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI


struct OrbitingCrown: View {
    @State private var ring1Angle: Double = 0
    @State private var ring2Angle: Double = 0
    @State private var crownOffset: CGFloat = 0

    var body: some View {
        ZStack {
            // Outer ring
            Circle()
                .stroke(Color.cGold.opacity(0.18), lineWidth: 1)
                .frame(width: 88, height: 88)
                .overlay(
                    Circle()
                        .fill(Color.cGold)
                        .frame(width: 5, height: 5)
                        .shadow(color: Color.cGold.opacity(0.8), radius: 3)
                        .offset(y: -44),
                    alignment: .center
                )
                .rotationEffect(.degrees(ring1Angle))

            // Inner ring
            Circle()
                .stroke(Color.cGold.opacity(0.12), lineWidth: 1)
                .frame(width: 70, height: 70)
                .rotationEffect(.degrees(ring2Angle))

            // Crown emoji
            Text("👑")
                .font(.system(size: 40))
                .shadow(color: Color.cGold.opacity(0.7), radius: 10)
                .offset(y: crownOffset)
        }
        .onAppear {
            withAnimation(
                .linear(duration: 12).repeatForever(autoreverses: false)
            ) {
                ring1Angle = 360
            }
            withAnimation(
                .linear(duration: 8).repeatForever(autoreverses: false)
            ) {
                ring2Angle = -360
            }
            withAnimation(
                .easeInOut(duration: 3).repeatForever(autoreverses: true)
            ) {
                crownOffset = -6
            }
        }
    }
}

