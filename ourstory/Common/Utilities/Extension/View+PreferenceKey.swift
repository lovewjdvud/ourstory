//
//  View+PreferenceKey.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/11/24.
//

import SwiftUI
extension View {
    func ouNavigationBarHidden(_ isHidden: Bool) -> some View {
        preference(key: OUNavBarHidden.self, value: isHidden)
    }
    
    func ouNavigationTitle(_ title: String) -> some View {
        preference(key: OUNavBarTitlePreferenceKey.self, value: title)
    }
    
    func ouNavigationSubtitle(_ subtitle: String?) -> some View {
        preference(key: OUNavBarSubtitlePreferenceKey.self, value: subtitle)
    }
    
    func ouNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: OUNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    func ouNavigationBarLeftItem(_ item: ()-> some View) -> some View {
        preference(key: OUNavBarLeftItemPreferenceKey.self, value: OUNavItemContainer(item(),
                                                                                      type: "left"))
    }
    
    func ouNavigationBarRightItem(_ item: ()-> some View) -> some View {
        preference(key: OUNavBarRightItemPreferenceKey.self, value: OUNavItemContainer(item(),
                                                                                       type: "right"))
    }
    
    func ouNavBarItems(title: String = "",
                       subtitle: String? = nil,
                       hidden: Bool = false) -> some View {
        self
            .ouNavigationTitle(title)
            .ouNavigationSubtitle(subtitle)
            .ouNavigationBarBackButtonHidden(hidden)
    }
}
