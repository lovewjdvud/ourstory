//
//  NavigationView.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/10/24.
//

import SwiftUI

struct ITNavigationViewLink<Label: View, Destination: View>: View {
    @ViewBuilder private let destination: () -> Destination
    @Environment(\.presentationMode) var presentationMode
    let label: Label
    var title: String? = nil
    init(@ViewBuilder destination: @escaping () -> Destination,
         @ViewBuilder label: () -> Label,
         title: String) {
        self.destination = destination
        self.label = label()
        self.title = title
    }
    var body: some View {
        ZStack(alignment: .leading) {
            label
            
            NavigationLink {
//                ITNavigationBarContainerView( content : {
//                    destination()
//                        .navigationBarHidden(true)
//                  
//                })
                
                ITNavigationBarContainerView(
                    left: {
//                        subTitleBudton
                }, content: {
                    destination()
                        .navigationBarHidden(true)
                }, right: {
                    
                }, 
                    title: title )
                
            } label: {
                
                
            }
            
            .opacity(0)
            .buttonStyle(PlainButtonStyle())
        }
    }
}



struct ITNavigationBarContainerView<L, Content,R>: View  where L: View,
                                                               Content: View,
                                                               R: View {
    let content: Content
    let left: L?
    let right: R?
    @State private var showBackButton: Bool = false
     var title: String? = ""
    @State private var subtitle: String? = nil
    @State private var leftNavigationBarItem: L? = nil
    @State private var rightNavigationBarItem: OUNavItemContainer? = nil
    @State private var isHidden: Bool = false

    
    init(@ViewBuilder left: () -> L?, @ViewBuilder content: () -> Content , @ViewBuilder right: () -> R?,title:String?) {
        self.left = left()
        self.title = title
        self.content = content()
        self.right = right()
       
    }
    
    private var naviagationView: some View {
        OUNavigationBarView(left: { self.left },
                            right: { rightNavigationBarItem },
                            showBackButton: showBackButton,
                            title: title,
                            subtitle: subtitle)
        
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if !isHidden {
                naviagationView
            } else {
                HStack { }.frame(height: 0)
            }
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
