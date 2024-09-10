//
//  Page.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/10/24.
//

import Foundation
enum Page: Int {
   case board = 0
   case profile = 1

   
   var icon: String {
      switch self {
      case .board:    return "main_tab_board"
         case .profile:     return "icon_main_profile"
      
      }
   }
   
   var title: String {
      switch self {
         case .board:    return "홈"
         case .profile:     return "노래 부르기"
     
      }
   }
}
