//
//  EnumeratedImage.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/11/24.
//

import SwiftUI

protocol EnumeratedImage {
    var rawValue: String { get }
}

extension EnumeratedImage {
    var image: Image {
        Image(self.rawValue)
    }
}

public enum ITImage: String, EnumeratedImage {

    case naviBackBtnIcon = "navi_back_icon_btn"
}

