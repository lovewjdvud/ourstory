//
//  View++.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/11/24.
//


import SwiftUI
extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}
