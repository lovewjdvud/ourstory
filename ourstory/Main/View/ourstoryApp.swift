//
//  ourstoryApp.swift
//  ourstory
//
//  Created by Songjeongpyeong on 8/23/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct ourstoryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            ContentView(
                store: Store(initialState: AppFeature.State()) {
                    AppFeature()
                }
            )
            
            
        }
    }
}
