//
//  AppDelegate.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/3/24.
//

import SwiftUI
import UIKit
import Firebase
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? ) -> Bool {
        // 앱 시작 시 실행될 코드
        print("Application did finish launching")
        FirebaseApp.configure() 
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // 앱 종료 시 실행될 코드
        print("Application will terminate")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        print("Application did finish GIDSignIn")
           return GIDSignIn.sharedInstance.handle(url)
       }
    
    
    
    // 필요한 다른 AppDelegate 메서드들을 여기에 추가할 수 있습니다.
}


//
