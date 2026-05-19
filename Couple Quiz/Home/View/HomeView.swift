//
//  HomeView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var router: AppRouter
    @State private var selectedCategoryID: String?
    @StateObject private var vm = HomeViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    let colors: [[Color]] = [
        [.purple.opacity(0.8), .purple],
        [.red.opacity(0.8), .orange],
        [.yellow, .orange],
        [.green, .mint],
        [.pink, .red],
        [.pink, .purple],
        [.red, .yellow],
        [.mint, .red]
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

                        ForEach(Array(vm.categories.enumerated()), id: \.element.id) { index, category in

                            Button {

                                selectedCategoryID = category.id

                            } label: {

                                CategoryCard(
                                    item: category,
                                    isSelected: selectedCategoryID == category.id,
                                    colors: colors[index]
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                startButton
            }
            .padding(.horizontal, 20)
        }
    }
}


// MARK: - Helper
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

    var startButton: some View {

        Button {
            router.showQuestions(
                vm.categories.first(where: { $0.id == selectedCategoryID })!
            )
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


// MARK: - Preview

#Preview {
    HomeView()
}
