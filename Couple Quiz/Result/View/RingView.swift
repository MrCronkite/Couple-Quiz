//
//  RingView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 25.05.26.
//

import SwiftUI


struct RingView: View {
    var progress: CGFloat
    var percent: Int

    var body: some View {
        ZStack {
            // Трек
            Circle()
                .stroke(Color(hex: "1E1E2A"), lineWidth: 10)
                .frame(width: 130, height: 130)

            // Заполненная дуга с градиентом
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        colors: [Color(hex: "A78BFA"), Color(hex: "FF6B6B")],
                        center: .center,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(270)
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .frame(width: 130, height: 130)
                .rotationEffect(.degrees(-90))

            // Текст внутри
            VStack(spacing: 3) {
                Text("\(percent)%")
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "F0EEF8"), Color(hex: "A78BFA")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Text("совпадение")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(hex: "5A5A78"))
                    .kerning(0.5)
            }
        }
    }
}
