//
//  SymbolButton.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct SymbolButton: View {
    let action: () -> Void
    let symbolName: String
    let color: Color
    let accessibilityLabel: String
    let accessibilityHint: String
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: symbolName)
                .foregroundColor(color)
                .frame(width: 30, height: 30, alignment: .center)
        })
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(Text(accessibilityLabel))
        .accessibilityHint(Text(accessibilityHint))

    }
}

struct SymbolButton_Previews: PreviewProvider {
    static var previews: some View {
        SymbolButton(action: {}, symbolName: "plus", color: .mobGreen, accessibilityLabel: "Add team member.", accessibilityHint: "Tap to add the specified name to your mob.")
    }
}
