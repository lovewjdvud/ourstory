//
//  OUText.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/3/24.
//

import Foundation
import SwiftUI


enum OUTextStyle {
    case regular,light, medium, semiBold, bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .light:
            return .pretendardLight(size)
        case .regular:
            return .pretendardRegular(size)
        case .medium:
            return .pretendardMedium(size)
        case .semiBold:
            return .pretendardSemiBold(size)
        case .bold:
            return .pretendardBold(size)
        }
    }
}

struct OUTextView: View {
   
    let text: String
    let size: CGFloat
    var style: OUTextStyle = .regular
    var color: Color = .black
    var maxLines: Int?
    var tracking: CGFloat = -0.5
    var lineSpacing: CGFloat = 0
    var alignment: TextAlignment = .leading
    var accentColor: Color = .black
    
   var body: some View {
      Text(text)
         .font(style.font(size: Utils.resizedFont(size)))
                     .foregroundColor(color)
                     .tracking(tracking)
                     .accentColor(accentColor)
                     .allowsTightening(true)
                     .multilineTextAlignment(alignment)
                     .lineLimit(maxLines)
                     .lineSpacing(lineSpacing)
       
   }
}
