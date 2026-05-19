//
//  QuestionsView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 19.05.26.
//

import SwiftUI

struct QuestionsView: View {

    @State private var currentIndex = 0
    @State private var selectedReaction: ReactionType?
    @State private var emoji = ReactionType.randomEmoji
    @State private var showRules = false

    let category: Category

    @EnvironmentObject var router: AppRouter

    var questions: [Question] {
        category.questions
    }

    var currentQuestion: Question {
         questions[currentIndex]
    }

    var progress: CGFloat {
        CGFloat(currentIndex + 1) / CGFloat(questions.count)
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

            VStack(spacing: 14) {

                topBar

                Spacer()

                questionCard

                reactions

                answerButton
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .alert("Правила игры", isPresented: $showRules) {

                Button("OK", role: .cancel) { }

            } message: {

                Text("""
                        По очереди отвечайте на вопросы.
                        
                        Отвечайте честно и не пропускайте интересные темы ❤️
                        """)
            }
        }
    }
}

// MARK: - Top Bar

extension QuestionsView {

    var topBar: some View {

        VStack(spacing: 18) {

            HStack {

                Button {
                    router.showMain()
                } label: {

                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 38, height: 38)
                        .background(Color.white.opacity(0.06))
                        .clipShape(Circle())
                }

                Spacer()

                Text("\(currentIndex + 1)/\(questions.count)")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.gray)
            }

            GeometryReader { geo in

                ZStack(alignment: .leading) {

                    Capsule()
                        .fill(Color.white.opacity(0.06))
                        .frame(height: 8)

                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [.purple, .pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: geo.size.width * progress,
                            height: 8
                        )
                }
            }
            .frame(height: 8)

            Text("\(category.emoji) \(category.name)")
                .padding(8)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .background(Color.purple.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 27))
        }
    }
}

// MARK: - Card

extension QuestionsView {

    var questionCard: some View {

            ZStack(alignment: .bottomTrailing) {

                RoundedRectangle(cornerRadius: 34)
                    .fill(Color.white.opacity(0.05))

                LinearGradient(
                    colors: [
                        Color.purple.opacity(0.25),
                        Color.pink.opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: 34))

                VStack(spacing: 24) {

                    HStack {

                        Spacer()

                        Button {

                            showRules = true

                        } label: {

                            Image(systemName: "questionmark")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: 34, height: 34)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }
                    }

                    Text(emoji)
                        .font(.system(size: 70))

                    Text(currentQuestion.text)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)

                    Spacer()
                }
                .padding(20)

                Text("\(currentIndex + 1)")
                    .font(.system(size: 120, weight: .black))
                    .foregroundColor(.white.opacity(0.04))
                    .padding(16)
            }
            .frame(height: 420)
        .overlay {
            RoundedRectangle(cornerRadius: 34)
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 1
                )
        }
    }
}

// MARK: - Reactions

extension QuestionsView {

    var reactions: some View {

        HStack(spacing: 14) {

            ForEach(ReactionType.allCases, id: \.self) { reaction in

                Button {

                    selectedReaction = reaction

                } label: {

                    VStack(spacing: 10) {

                        Text(reaction.emoji)
                            .font(.system(size: 28))

                        Text(reaction.title)
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 94)
                    .background(
                        selectedReaction == reaction
                        ? Color.purple.opacity(0.35)
                        : Color.white.opacity(0.05)
                    )
                    .overlay {

                        RoundedRectangle(cornerRadius: 24)
                            .stroke(
                                selectedReaction == reaction
                                ? Color.purple
                                : Color.white.opacity(0.06),
                                lineWidth: 1.5
                            )
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
        }
    }
}

// MARK: - Button

extension QuestionsView {

    var answerButton: some View {

        Button {

            guard currentIndex < questions.count - 1 else {
                return
            }

            withAnimation(.spring) {

                currentIndex += 1
                selectedReaction = nil
            }

            emoji = ReactionType.randomEmoji

        } label: {

            Text("Ответить ❤️")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .disabled(selectedReaction == nil)
        .opacity(selectedReaction == nil ? 0.5 : 1)
    }
}



#Preview {
    QuestionsView(category: .init(
        id: "",
        name: "Прошлое & Детство",
        emoji: "📸",
        isPremium: false,
        questions: [Question(id: "", text: "Каким ребёнком она была — тихим или непоседливым?")])
    )
}

