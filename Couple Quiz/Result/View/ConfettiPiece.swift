//
//  ConfettiPiece.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 25.05.26.
//

import SwiftUI

struct ConfettiPiece: Identifiable {
    let id = UUID()
    let x: CGFloat
    let size: CGFloat
    let color: Color
    let isCircle: Bool
    let delay: Double
    let duration: Double

    static func generate(count: Int) -> [ConfettiPiece] {
        let colors: [Color] = [
            Color(hex: "A78BFA"), Color(hex: "FF6B6B"),
            Color(hex: "FFD166"), Color(hex: "34D399"),
            Color(hex: "60A5FA"), Color(hex: "F472B6")
        ]
        
        return (0..<count).map { _ in
            ConfettiPiece(
                x: CGFloat.random(in: 0...1),
                size: CGFloat.random(in: 4...9),
                color: colors.randomElement()!,
                isCircle: Bool.random(),
                delay: Double.random(in: 0...3),
                duration: Double.random(in: 2.5...4.5)
            )
        }
    }
}

struct ConfettiView: View {
    let pieces: [ConfettiPiece]
    @State private var animate = false

    var body: some View {
        GeometryReader { geo in
            ForEach(pieces) { piece in
                piece.color
                    .frame(width: piece.size, height: piece.size)
                    .clipShape(piece.isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 2)))
                    .rotationEffect(.degrees(animate ? 720 : 0))
                    .offset(
                        x: piece.x * geo.size.width,
                        y: animate ? geo.size.height + 20 : -20
                    )
                    .opacity(animate ? 0 : 1)
                    .animation(
                        .linear(duration: piece.duration)
                        .delay(piece.delay)
                        .repeatForever(autoreverses: false),
                        value: animate
                    )
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
        .onAppear {
            DispatchQueue.main.async {
                animate = true
            }
        }
    }
}


struct AnyShape: Shape {
    private let pathBuilder: @Sendable (CGRect) -> Path
    init<S: Shape>(_ shape: S) {
        pathBuilder = { rect in shape.path(in: rect) }
    }
    func path(in rect: CGRect) -> Path { pathBuilder(rect) }
}
