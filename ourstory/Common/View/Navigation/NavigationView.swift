//
//  NavigationView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/10/24.
//

import SwiftUI

struct ITNavigationViewLink<Label: View, Destination: View>: View {
    @ViewBuilder private let destination: () -> Destination
    let label: Label
    
    init(@ViewBuilder destination: @escaping () -> Destination,
         @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    var body: some View {
        ZStack(alignment: .leading) {
            label
            
            NavigationLink {
                
                destination()
                    .navigationBarHidden(true)
                
            } label: {
                
                
            }
            .opacity(0)

            .buttonStyle(PlainButtonStyle())
        }
    }
}
