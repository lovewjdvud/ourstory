//
//  Color.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/3/24.
//

import SwiftUI

extension Color {
    init(_ rgb: (CGFloat, CGFloat, CGFloat), opacity: CGFloat = 1) {
        self.init(red: rgb.0/255, green: rgb.1/255, blue: rgb.2/255, opacity: opacity)
    }

    static let primaryColor: Color = Color((255, 197, 0))
    static let darkTextColor: Color = Color((80, 80, 80))
    static let textColor: Color = Color((150, 150, 150))
    
    
}
