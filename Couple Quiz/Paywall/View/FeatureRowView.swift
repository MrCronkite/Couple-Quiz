//
//  FeatureRowView.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 18.05.26.
//

import SwiftUI


struct FeatureRow: View {
    let item: FeatureItem

    var body: some View {
        HStack(spacing: 10) {
            Rectangle()
                .fill(item.accentColor)
                .frame(width: 2)
                .cornerRadius(1)

            Text(item.emoji)
                .font(.system(size: 15))
                .frame(width: 32, height: 32)
                .background(item.accentColor.opacity(0.12))
                .cornerRadius(9)

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
