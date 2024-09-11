//
//  NavigationView+PreferenceKey.swift
//  ourstory
//
//  Created by Songjeongpyeong on 9/11/24.
//

import SwiftUI

struct OUNavBarHidden: PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}


struct OUNavBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct OUNavBarSubtitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct OUNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        defaultValue = nextValue()
    }
}

struct OUNavBarLeftItemPreferenceKey: PreferenceKey {
    static var defaultValue: OUNavItemContainer = OUNavItemContainer(EmptyView(),
                                                         type: "left")
    static func reduce(value: inout OUNavItemContainer,
                       @ViewBuilder nextValue: () -> OUNavItemContainer) {
        value = nextValue()
    }
}

struct OUNavBarRightItemPreferenceKey: PreferenceKey {
    static var defaultValue: OUNavItemContainer = OUNavItemContainer(EmptyView(),
                                                                     type: "right")
    static func reduce(value: inout OUNavItemContainer,
                       @ViewBuilder nextValue: () -> OUNavItemContainer) {
        value = nextValue()
    }
}


struct OUNavItemContainer: View, Equatable {
    static func == (lhs: OUNavItemContainer,
                    rhs: OUNavItemContainer) -> Bool {
        lhs.type == rhs.type
    }
    
    let content: AnyView
    let type: String
    
    init(_ content: any View, type: String) {
        self.content = AnyView(content)
        self.type = type
    }
    
    var body: some View {
        content
    }
}
