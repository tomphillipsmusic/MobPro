//
//  LargeTextScrollView.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 11/1/22.
//

import SwiftUI

struct LargeTextScrollView: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    let maxSizeBeforeScroll: ContentSizeCategory
    
    func body(content: Content) -> some View {
        if sizeCategory > maxSizeBeforeScroll {
            ScrollView {
                content
            }
        } else {
            content
        }
    }
}

extension View {
    func largeTextScrollView(maxSizeBeforeScroll: ContentSizeCategory = .large) -> some View {
        modifier(LargeTextScrollView(maxSizeBeforeScroll: maxSizeBeforeScroll))
    }
}
