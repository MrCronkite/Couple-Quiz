//
//  PaywallView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI


// MARK: - Main PaywallView

struct PaywallView: View {

    @State private var showCloseButton = false
    @State private var selectedPlanIndex: Int = 1

    @EnvironmentObject var router: AppRouter

    private let plans: [PlanOption] = [
        PlanOption(
            period: "Месяц",
            price: "299₽",
            perLabel: "/мес",
            badge: nil,
            saving: nil
        ),
        PlanOption(
            period: "Год",
            price: "1490₽",
            perLabel: "≈ 124₽/мес",
            badge: "🔥 Выгодно",
            saving: "−58%"
        ),
        PlanOption(
            period: "Навсегда",
            price: "2490₽",
            perLabel: "разово",
            badge: nil,
            saving: nil
        ),
    ]

    private let features: [FeatureItem] = [
        FeatureItem(emoji: "🌶️", name: "18+ категории",
                    description: "Горячие, дерзкие и откровенные темы",
                    accentColor: Color(hex: "#FF6B6B")),
        FeatureItem(emoji: "♾️", name: "Безлимитные вопросы",
                    description: "300+ вопросов без ограничений и блокировок",
                    accentColor: Color(hex: "#A78BFA")),
        FeatureItem(
            emoji: "🆕",
            name: "Без рекламы",
            description: "Свежий контент — никогда не надоест",
            accentColor: Color(hex: "#FFD166")
        )
    ]

    var body: some View {
        ZStack {
            // ── Background ──────────────────────────────────────────────────
            Color.cBg.ignoresSafeArea()

            // Gold glow top
            RadialGradient(
                colors: [Color.cGold.opacity(0.14), Color.cGold2.opacity(0.06), .clear],
                center: .init(x: 0.5, y: 0.1),
                startRadius: 0,
                endRadius: 280
            )
            .ignoresSafeArea()

            // Purple glow bottom
            RadialGradient(
                colors: [Color.cAccent3.opacity(0.08), .clear],
                center: .bottom,
                startRadius: 0,
                endRadius: 220
            )
            .ignoresSafeArea()

            // ── Content ─────────────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // ── Hero ─────────────────────────────────────────────────
                    VStack(spacing: 0) {
                        OrbitingCrown()
                            .padding(.top, 22)

                        // Premium badge
                        Text("✦ Premium")
                            .font(.system(size: 14, weight: .bold))
                            .tracking(1.2)
                            .foregroundColor(Color(hex: "#1a0800"))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 4)
                            .background(
                                LinearGradient(
                                    colors: [Color.cGold, Color.cGold2],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .clipShape(Capsule())
                            .shadow(color: Color.cGold2.opacity(0.3), radius: 8, y: 3)
                            .padding(.top, 14)

                        // Title
                        Group {
                            Text("Откройте всё\nсамое ")
                                .font(.system(size: 26, weight: .black, design: .serif))
                                .foregroundColor(Color.cText)
                            + Text("смелое")
                                .font(.system(size: 26, weight: .black, design: .serif))
                                .italic()
                                .foregroundColor(Color.cGold)
                        }
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.top, 12)

                        TrialPill()
                            .padding(.top, 12)
                    }
                    .padding(.horizontal, 16)

                    Spacer()

                    // ── Features ─────────────────────────────────────────────
                    VStack(spacing: 6) {
                        ForEach(features) { item in
                            FeatureRow(item: item)
                                .frame(maxHeight: 50)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 14)

                    Spacer()

                    // ── Divider ───────────────────────────────────────────────
                    HStack(spacing: 10) {
                        dividerLine
                        Text("Выберите план")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(Color.cText3)
                            .tracking(1)
                            .textCase(.uppercase)
                        dividerLine
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 18)

                    // ── Plans ─────────────────────────────────────────────────
                    HStack(spacing: 7) {
                        ForEach(plans.indices, id: \.self) { i in
                            PlanCard(plan: plans[i], isSelected: selectedPlanIndex == i)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedPlanIndex = i
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 16)

                    // ── CTA ───────────────────────────────────────────────────
                    VStack(spacing: 8) {
                        ShimmerCTAButton(title: "Начать бесплатно на 3 дня ✦")

                        VStack(spacing: 2) {
                            Text("Без списания во время пробного периода.")
                                .foregroundColor(Color.cText3)
                            Text("Отмена в любой момент в настройках App Store.")
                                .foregroundColor(Color.cText2)
                        }
                        .font(.system(size: 10))
                        .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 14)

                    // ── Footer links ──────────────────────────────────────────
                    HStack(spacing: 4) {
                        footerLink("Восстановить покупку")
                        footerDot
                        footerLink("Условия")
                        footerDot
                        footerLink("Конфиденциальность")
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 32)
                }
            }

            // ── Close button ─────────────────────────────────────────────────
            VStack {
                HStack {
                    Spacer()
                    Button {
                        router.showMain()
                    } label: {
                        Text("✕")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color.cText3)
                            .frame(width: 28, height: 28)
                            .background(Color.cSurface2)
                            .overlay(
                                Circle().stroke(Color.white.opacity(0.07), lineWidth: 1)
                            )
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 18)
                }
                .padding(.top, 8)

                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        showCloseButton = true
                    }
                }
            }
        }
    }

    // ── Helpers

    private var dividerLine: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [.clear, Color.white.opacity(0.07), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 1)
    }

    private func footerLink(_ title: String) -> some View {
        Button(action: {}) {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color.cText3)
        }
    }

    private var footerDot: some View {
        Circle()
            .fill(Color.cText3.opacity(0.5))
            .frame(width: 2, height: 2)
    }
}

// MARK: - Preview

#Preview {
    PaywallView()
        .preferredColorScheme(.dark)
}
