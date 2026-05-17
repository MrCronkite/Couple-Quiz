//
//  Color+Ext.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 17.05.26.
//

import SwiftUI

// MARK: - Color palette

extension Color {
    static let cBg       = Color(hex: "#0C0C14")
    static let cSurface  = Color(hex: "#16161F")
    static let cSurface2 = Color(hex: "#1E1E2A")
    static let cAccent   = Color(hex: "#FF6B6B")
    static let cAccent3  = Color(hex: "#A78BFA")
    static let cGold     = Color(hex: "#FFD166")
    static let cGold2    = Color(hex: "#FF9F4A")
    static let cGreen    = Color(hex: "#34D399")
    static let cText     = Color(hex: "#F0EEF8")
    static let cText2    = Color(hex: "#9B9BB5")
    static let cText3    = Color(hex: "#5A5A78")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
