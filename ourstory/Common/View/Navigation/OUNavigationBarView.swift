//
//  ITNavigationBarView.swift
//  iuttalk-iOS
//
//  Created by 이전희 on 1/24/24.
//

import SwiftUI

struct OUNavigationBarView<L, R>: View where L: View,
                                             R: View {
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String?
    let subtitle: String?
    
    @ViewBuilder private let leftNavigationBarItem: () -> L
    @ViewBuilder private let rightNavigationBarItem: () -> R
    
    init(@ViewBuilder left leftNavigationBarItem: @escaping (() -> L) = { EmptyView() },
         @ViewBuilder right rightNavigationBarItem: @escaping (() -> R) = { EmptyView() },
         showBackButton: Bool = true,
         title: String? = "",
         subtitle: String? = nil) {
        self.leftNavigationBarItem = leftNavigationBarItem
        self.rightNavigationBarItem = rightNavigationBarItem
        self.showBackButton = showBackButton
        self.title = title
        self.subtitle = subtitle
   
    }
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            } else {
                subTitleBudton
            }
            // leftNavigationBarItem()
            Spacer()
            titleSection
            Spacer()
            rightNavigationBarItem()
        }
        .padding()
        .tint(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.mainBackgroundColor)
        .border(width: 1, edges: [.bottom], color: .dividerColor)
    }
}

extension OUNavigationBarView {
    
    
    private var subTitleBudton: some View {
        OUTextIconButton(ITImage.naviBackBtnIcon.image, title: title) {
           presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var backButton: some View {
        OUIconButton(ITImage.naviBackBtnIcon.image) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 4) {
            Text("")
                .font(.title)
                .fontWeight(.semibold)
            if let subtitle = subtitle {
                Text(subtitle)
            }
        }
    }
}
