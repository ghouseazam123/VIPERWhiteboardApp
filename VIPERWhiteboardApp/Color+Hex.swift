//
//  Color+Hex.swift
//  VIPERWhiteboardApp
//
//  Created by next on 07/11/25.

import SwiftUI
import UIKit

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, opacity: alpha)
    }

    func toHexWithAlpha() -> (hex: String, alpha: Double) {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (String(format: "%02X%02X%02X", Int(red*255), Int(green*255), Int(blue*255)), Double(alpha))
    }

    func withOpacity(_ alpha: Double) -> Color {
        let (hex, _) = self.toHexWithAlpha()
        return Color(hex: hex, alpha: alpha)
    }
}






