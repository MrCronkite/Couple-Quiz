//
//  PageIndicator.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

struct PageIndicator: View {

    let currentPage: Int
    let totalPages: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(
                        index == currentPage
                        ? Color.purple
                        : Color.white.opacity(0.18)
                    )
                    .frame(
                        width: index == currentPage ? 24 : 8,
                        height: 8
                    )
                    .animation(.spring(), value: currentPage)
            }
        }
    }
}
