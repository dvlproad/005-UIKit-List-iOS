//
//  TSTSSwiftUIView.swift
//  TSDemoDemo
//
//  Created by ciyouzen on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension Color {
    // 从十六进制颜色字符串生成 Color
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 如果颜色字符串以 # 开头，去掉 #
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        // 默认颜色值
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
    
    // 随机颜色生成器
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1),
            opacity: Double.random(in: 0...1)
        )
    }
}
