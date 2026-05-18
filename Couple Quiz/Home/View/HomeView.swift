//
//  HomeView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var router: AppRouter

    let items: [CategoryItem] = [
        .init(
            emoji: "💜",
            title: "Романтика",
            subtitle: "32 вопроса",
            colors: [.purple.opacity(0.8), .purple],
            isPremium: false,
            isSelected: true
        ),

        .init(
            emoji: "🔥",
            title: "Откровенно",
            subtitle: "28 вопросов",
            colors: [.red.opacity(0.8), .orange],
            isPremium: false,
            isSelected: false
        ),

        .init(
            emoji: "🤣",
            title: "Юмор & Смех",
            subtitle: "24 вопроса",
            colors: [.yellow, .orange],
            isPremium: false,
            isSelected: false
        ),

        .init(
            emoji: "🧠",
            title: "Глубокие",
            subtitle: "20 вопросов",
            colors: [.green, .mint],
            isPremium: false,
            isSelected: false
        ),

        .init(
            emoji: "🌶️",
            title: "18+ Горячие",
            subtitle: "Premium",
            colors: [.pink, .red],
            isPremium: true,
            isSelected: false
        ),

        .init(
            emoji: "💋",
            title: "18+ Дерзкие",
            subtitle: "Premium",
            colors: [.pink, .purple],
            isPremium: true,
            isSelected: false
        )
    ]

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

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

            VStack(alignment: .leading, spacing: 0) {

                header

                ScrollView(showsIndicators: false) {

                    LazyVGrid(columns: columns, spacing: 12) {

                        ForEach(items) { item in
                            CategoryCard(item: item)
                        }
                    }
                }

                startButton
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Header

extension HomeView {

    var header: some View {

        VStack(alignment: .leading, spacing: 6) {

            Text("Выбери тему 🎭")
                .font(
                    .system(size: 34, weight: .black, design: .serif)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white, Color.purple.opacity(0.85)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Text("Выбери одну или несколько тематик")
                .font(.system(size: 16))
                .foregroundColor(.gray)
        }
        .padding(.top, 20)
        .padding(.bottom, 24)
    }
}

// MARK: - Button

extension HomeView {

    var startButton: some View {

        Button {

        } label: {

            Text("Начать игру →")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    LinearGradient(
                        colors: [.purple, .indigo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .padding(.vertical, 20)
    }
}

// MARK: - Card

struct CategoryCard: View {

    let item: CategoryItem

    var body: some View {

        ZStack(alignment: .leading) {

            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white.opacity(0.06))

            LinearGradient(
                colors: item.colors,
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


                Spacer()

                VStack(alignment: .leading, spacing: 4) {

                    Text(item.title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)

                    Text(item.subtitle)
                        .font(.system(size: 15))
                        .foregroundColor(
                            item.isPremium ? .yellow : .gray
                        )
                }
            }
            .padding(16)


        }
        .frame(height: 160)
        .overlay {

            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    item.isSelected
                    ? Color.purple.opacity(0.6)
                    : Color.white.opacity(0.06),
                    lineWidth: item.isSelected ? 3.5 : 1
                )
        }
    }
}

// MARK: - Model



// MARK: - Preview

#Preview {
    HomeView()
}
