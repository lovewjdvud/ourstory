//
//  Utils.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/3/24.
//

import Foundation
import SwiftUI

class Utils {
    
    public static func resizedFont(_ fontSize: CGFloat, _ destSize: CGFloat? = nil) -> CGFloat {
        var screenSize = UIScreen.main.bounds.width
        if let destSize = destSize {
            screenSize = destSize
        }
        let ratio = screenSize / 375.0
        return ratio * fontSize
    }
    
}
