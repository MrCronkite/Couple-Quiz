//
//  OnboardingView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct OnboardingView: View {

    @EnvironmentObject var router: AppRouter

    @State private var currentPage = 0

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

            Circle()
            .fill(OnboardingPage.pages[currentPage].glowColor.opacity(0.18))
            .frame(width: 420, height: 420)
            .blur(radius: 70)
            .offset(y: -150)

            VStack(spacing: 0) {

                TabView(selection: $currentPage) {
                    ForEach(Array(OnboardingPage.pages.enumerated()), id: \.offset) { index, page in
                        OnboardingContentView(
                            page: page,
                            isLast: index == OnboardingPage.pages.count - 1,
                            currentPage: $currentPage
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                VStack(spacing: 24) {

                    PageIndicator(
                        currentPage: currentPage,
                        totalPages: OnboardingPage.pages.count
                    )
                    Button {
                        if currentPage < OnboardingPage.pages.count - 1 {
                            withAnimation(.spring()) {
                                currentPage += 1
                            }
                        } else {
                            router.showPaywall()
                        }
                    } label: {
                        Text(currentPage == OnboardingPage.pages.count - 1
                             ? "Начать игру"
                             : "Начать 💜")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .background(
                            LinearGradient(
                                colors: OnboardingPage.pages[currentPage].primaryGradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(
                            color: OnboardingPage.pages[currentPage]
                                .primaryGradient
                                .first?
                                .opacity(0.45) ?? .purple,
                            radius: 18,
                            y: 8
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 44)
                .padding(.top, 10)
                .background(.clear)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
