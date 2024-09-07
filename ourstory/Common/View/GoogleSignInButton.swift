//
//  GoogleSignInButton.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/3/24.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        return GIDSignInButton()
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
}
