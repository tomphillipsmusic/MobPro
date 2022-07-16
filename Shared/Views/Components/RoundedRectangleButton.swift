//
//  RoundedRectangleButton.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/16/22.
//

import SwiftUI

struct RoundedRectangleButton: View {
    let label: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(label, action: action)
        .foregroundColor(.white)
        .buttonStyle(.borderedProminent)
        .tint(.mobRed)
        .controlSize(.large)
    }
}

struct RoundedRectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleButton(label: "End Mob Session", color: .mobRed, action: {})
    }
}
