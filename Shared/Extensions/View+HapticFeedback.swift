//
//  View+HapticFeedback.swift
//  MobPro
//
//  Created by Tom Phillips on 8/6/22.
//

import SwiftUI

extension View {
    func hapticFeedbackOnTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) -> some View {
      self.onTapGesture {
        let impact = UIImpactFeedbackGenerator(style: style)
        impact.impactOccurred()
      }
    }
}
