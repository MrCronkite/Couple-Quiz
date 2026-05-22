//
//  MatchResultView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 22.05.26.
//

import SwiftUI


struct MatchResultView: View {

    @StateObject private var vm: MatchResultViewModel
    @EnvironmentObject var route: AppRouter

    init(reactions: [ReactionType]) {
        _vm = StateObject(wrappedValue: MatchResultViewModel(reactions: reactions))
    }

    var body: some View {
        ZStack {

            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.08),
                    Color(red: 0.08, green: 0.07, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {

                Spacer()

                // MARK: - Circle Progress
                ZStack {

                    Circle()
                        .stroke(Color.white.opacity(0.08), lineWidth: 14)

                    Circle()
                        .trim(from: 0, to: CGFloat(vm.compatibilityPercent) / 100)
                        .stroke(
                            LinearGradient(
                                colors: [.purple, .pink],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 14, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 1), value: vm.compatibilityPercent)

                    Text("\(vm.compatibilityPercent)%")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(width: 150, height: 150)

                // MARK: - Title
                Text(vm.resultTitle)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)

                // MARK: - Subtitle
                Text(vm.resultSubtitle)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 28)

                // MARK: - Stats
                HStack(spacing: 12) {

                    StatView(value: "\(vm.knewCount)", title: "Совпало ответов")

                    StatView(value: "\(vm.surprisedCount)", title: "Открытий сделано")

                    StatView(value: "\(vm.didntKnowCount)", title: "промахов")
                }
                .padding(.horizontal, 16)

                // MARK: - Buttons
                VStack(spacing: 12) {

                    Button {

                    } label: {
                        Text("Сыграть ещё")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    Button {

                    } label: {
                        Text("Поделиться")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.08))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 16)

                Spacer()
            }
        }
    }
}

struct StatView: View {

    let value: String
    let title: String

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)

            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .padding()
        .background(Color.white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

