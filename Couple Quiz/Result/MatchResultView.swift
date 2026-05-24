//
//  MatchResultView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 22.05.26.
//

import SwiftUI

struct MatchResultView: View {

    @StateObject private var vm: MatchResultViewModel
    @EnvironmentObject var router: AppRouter

    // Анимации
    @State private var ringProgress: CGFloat = 0
    @State private var displayedPercent: Int = 0
    @State private var glowScale: CGFloat = 1
    @State private var glowOpacity: Double = 0.6
    @State private var showContent: Bool = false
    @State private var confettiPieces: [ConfettiPiece] = []

    init(reactions: [ReactionType]) {
        _vm = StateObject(wrappedValue: MatchResultViewModel(reactions: reactions))
    }

    var body: some View {
        ZStack {
            // Фон
            Color(hex: "0C0C14").ignoresSafeArea()

            // Ambient glow
            RadialGradient(
                colors: [Color(hex: "A78BFA").opacity(0.15), .clear],
                center: .top,
                startRadius: 0,
                endRadius: 200
            )
            .ignoresSafeArea()
            .scaleEffect(glowScale)
            .opacity(glowOpacity)

            // Конфетти
            ConfettiView(pieces: confettiPieces)

            // Основной контент
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {

                    // Кольцо
                    RingView(progress: ringProgress, percent: displayedPercent)
                        .padding(.top, 44)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 10)
                        .animation(.easeOut(duration: 0.5).delay(0.1), value: showContent)

                    // Заголовок
                    Text(vm.resultTitle)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "F0EEF8"))
                        .padding(.top, 20)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 10)
                        .animation(.easeOut(duration: 0.5).delay(0.25), value: showContent)

                    // Подзаголовок
                    Text(vm.resultSubtitle)
                        .font(.system(size: 18, weight: .light))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "9B9BB5"))
                        .lineSpacing(4)
                        .padding(.top, 8)
                        .padding(.horizontal, 8)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 10)
                        .animation(.easeOut(duration: 0.5).delay(0.35), value: showContent)

                    // Стат-карточки
                    HStack(spacing: 8) {
                        StatCard(
                            emoji: "✅",
                            value: vm.knewCount,
                            label: "Знал",
                            valueColor: Color(hex: "34D399"),
                            topColor: [Color(hex: "34D399"), Color(hex: "059669")]
                        )
                        StatCard(
                            emoji: "😮",
                            value: vm.surprisedCount,
                            label: "Удивил",
                            valueColor: Color(hex: "FFD166"),
                            topColor: [Color(hex: "FFD166"), Color(hex: "FF9F4A")]
                        )
                        StatCard(
                            emoji: "❌",
                            value: vm.didntKnowCount,
                            label: "Не знал",
                            valueColor: Color(hex: "FF6B6B"),
                            topColor: [Color(hex: "FF6B6B"), Color(hex: "FF4040")]
                        )
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 4)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 10)
                    .animation(.easeOut(duration: 0.5).delay(0.45), value: showContent)

                    // Insight карточка
                    InsightCard(surprisedCount: vm.surprisedCount)
                        .padding(.top, 2)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 10)
                        .animation(.easeOut(duration: 0.5).delay(0.55), value: showContent)

                    Spacer()

                    // Кнопки
                    VStack(spacing: 8) {
                        // Поделиться
                        Button {
                            shareResult()
                        } label: {
                            HStack(spacing: 8) {
                                Text("Поделиться результатом")
                                Text("📤")
                            }
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "A78BFA"), Color(hex: "7C3AED")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: Color(hex: "7C3AED").opacity(0.4), radius: 12, y: 6)
                        }
                        .buttonStyle(ScaleButtonStyle())

                        Button {
                            router.showMain()
                        } label: {
                            HStack(spacing: 8) {
                                Text("🎲")
                                Text("Сыграть ещё раз")
                            }
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(Color(hex: "1E1E2A"))
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white.opacity(0.07), lineWidth: 1)
                            )
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .padding(.top, 14)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 10)
                    .animation(.easeOut(duration: 0.5).delay(0.65), value: showContent)

                    Spacer(minLength: 32)
                }
                .padding(.horizontal, 22)
            }
        }
        .onAppear { startAnimations() }
    }

    // MARK: — Анимации

    func startAnimations() {
        // Конфетти
        confettiPieces = ConfettiPiece.generate(count: 58)

        // Контент появляется
        withAnimation { showContent = true }

        // Кольцо заполняется
        withAnimation(.timingCurve(0.25, 1, 0.5, 1, duration: 1.4).delay(0.3)) {
            ringProgress = CGFloat(vm.percent) / 100
        }

        // Счётчик процентов
        let target = vm.percent
        let steps = 60
        for i in 0...steps {
            let delay = 0.3 + (1.4 / Double(steps)) * Double(i)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let eased = 1 - pow(1 - Double(i) / Double(steps), 3)
                displayedPercent = Int(eased * Double(target))
            }
        }
    }

    func shareResult() {
        let text = "Я знаю свою девушку на \(vm.percent)%! \(vm.resultTitle)\nПроверь себя в Couple Quiz 💜"
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.rootViewController?
            .present(av, animated: true)
    }
}

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

// ScaleButtonStyle — нажатие уменьшает кнопку
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// Preview
#Preview {
   MatchResultView(reactions: [])
}
