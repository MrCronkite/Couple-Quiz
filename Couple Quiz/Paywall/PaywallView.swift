//
//  PaywallView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI


// ── Orbiting crown ──────────────────────────────────────────────────────────

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
            withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                ring1Angle = 360
            }
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                ring2Angle = -360
            }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                crownOffset = -6
            }
        }
    }
}

// ── Trial pill with pulsing dot ─────────────────────────────────────────────

struct TrialPill: View {
    @State private var dotScale: CGFloat = 1
    @State private var dotOpacity: Double = 1

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Color.cGold)
                .frame(width: 6, height: 6)
                .shadow(color: Color.cGold.opacity(0.8), radius: 3)
                .scaleEffect(dotScale)
                .opacity(dotOpacity)

            Text("3 дня бесплатно, затем по выбранному тарифу")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.cGold)
                .tracking(0.3)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(Color.cGold.opacity(0.07))
        .overlay(
            Capsule().stroke(Color.cGold.opacity(0.2), lineWidth: 1)
        )
        .clipShape(Capsule())
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                dotScale = 0.7
                dotOpacity = 0.4
            }
        }
    }
}

// ── Social proof strip ───────────────────────────────────────────────────────

struct SocialProofStrip: View {
    var body: some View {
        HStack(spacing: 8) {
            // Overlapping avatars
            HStack(spacing: -6) {
                ForEach(["🧑", "👩", "🧑‍🦱"], id: \.self) { emoji in
                    Text(emoji)
                        .font(.system(size: 11))
                        .frame(width: 22, height: 22)
                        .background(Color.cSurface2)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.cBg, lineWidth: 1.5))
                }
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Group {
                    Text("47 000+ пар").fontWeight(.semibold).foregroundColor(Color.cText)
                    + Text(" уже открыли Premium").foregroundColor(Color.cText2)
                }
                .font(.system(size: 9))
                Text("Рейтинг в App Store")
                    .font(.system(size: 9, weight: .light))
                    .foregroundColor(Color.cText2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Stars + rating
            VStack(spacing: 1) {
                HStack(spacing: 1) {
                    ForEach(0..<5, id: \.self) { _ in
                        Text("⭐").font(.system(size: 8))
                    }
                }
                Text("4.9")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(Color.cGold)
            }
        }
        .padding(.horizontal, 11)
        .padding(.vertical, 9)
        .background(Color.cSurface)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.07), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

// ── Feature row ──────────────────────────────────────────────────────────────

struct FeatureRow: View {
    let item: FeatureItem

    var body: some View {
        HStack(spacing: 10) {
            // Accent left bar
            Rectangle()
                .fill(item.accentColor)
                .frame(width: 2)
                .cornerRadius(1)

            // Icon
            Text(item.emoji)
                .font(.system(size: 15))
                .frame(width: 32, height: 32)
                .background(item.accentColor.opacity(0.12))
                .cornerRadius(9)

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Text(item.name)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color.cText)
                Text(item.description)
                    .font(.system(size: 9.5, weight: .light))
                    .foregroundColor(Color.cText2)
                    .lineSpacing(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Check
            Text("✓")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(Color.cGreen)
                .frame(width: 18, height: 18)
                .background(Color.cGreen.opacity(0.15))
                .overlay(
                    Circle().stroke(Color.cGreen.opacity(0.3), lineWidth: 1)
                )
                .clipShape(Circle())
        }
        .padding(.vertical, 10)
        .padding(.trailing, 12)
        .background(Color.cSurface)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(Color.white.opacity(0.07), lineWidth: 1)
        )
        .cornerRadius(13)
    }
}

// ── Plan card ────────────────────────────────────────────────────────────────

struct PlanCard: View {
    let plan: PlanOption
    let isSelected: Bool

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 2) {
                // Period label (extra top space if badge exists)
                Text(plan.period)
                    .font(.system(size: 8.5))
                    .foregroundColor(Color.cText2)
                    .padding(.top, plan.badge != nil ? 10 : 4)

                // Price
                Text(plan.price)
                    .font(.system(size: 17, weight: .bold, design: .serif))
                    .foregroundColor(isSelected ? Color.cGold : Color.cText)

                // Per label
                Text(plan.perLabel)
                    .font(.system(size: 8, weight: .light))
                    .foregroundColor(Color.cText3)

                // Saving badge
                if let saving = plan.saving {
                    Text(saving)
                        .font(.system(size: 7.5, weight: .semibold))
                        .foregroundColor(Color.cGreen)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 1)
                        .background(Color.cGreen.opacity(0.1))
                        .cornerRadius(4)
                        .padding(.top, 3)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            .background(
                isSelected
                    ? Color.cGold.opacity(0.05)
                    : Color.cSurface
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected ? Color.cGold : Color.white.opacity(0.07),
                        lineWidth: isSelected ? 1.5 : 1.5
                    )
            )
            .cornerRadius(16)
            .shadow(
                color: isSelected ? Color.cGold.opacity(0.08) : .clear,
                radius: 12, y: 4
            )

            // Top badge
            if let badge = plan.badge {
                Text(badge)
                    .font(.system(size: 7.5, weight: .bold))
                    .foregroundColor(Color(hex: "#1a0800"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        LinearGradient(
                            colors: [Color.cGold, Color.cGold2],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(6)
                    .shadow(color: Color.cGold2.opacity(0.3), radius: 4)
                    .offset(y: -9)
            }
        }
    }
}

// ── Shimmer CTA button ───────────────────────────────────────────────────────

struct ShimmerCTAButton: View {
    let title: String
    @State private var shimmerOffset: CGFloat = -200

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.cGold, Color.cGold2],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Shimmer sweep
            GeometryReader { geo in
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.25), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * 0.5)
                    .offset(x: shimmerOffset)
                    .clipped()
            }
            .clipped()

            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color(hex: "#1a0800"))
                .tracking(0.2)
        }
        .frame(height: 52)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.cGold2.opacity(0.35), radius: 16, y: 6)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 2.5)
                .repeatForever(autoreverses: false)
                .delay(0.5)
            ) {
                shimmerOffset = 500
            }
        }
    }
}

// MARK: - Main PaywallView

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPlanIndex: Int = 1

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
                        dismiss()
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
