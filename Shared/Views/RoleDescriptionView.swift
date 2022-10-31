//
//  RoleDescriptionView.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import SwiftUI

struct RoleDescriptionView: View {
    @Environment(\.dismiss) var dismiss
    @AccessibilityFocusState var isFocusedOnDescription: Bool
    let role: Role
    
    var body: some View {
        VStack {
            CloseButton()
            
            VStack {
                Text("You are \(role == .researcher ? "a" : "the") \(role.rawValue) \(Image(systemName: role.symbolName))")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(role.color)

                VStack(alignment: .leading) {
                    ForEach(role.responsibilities, id:\.text) { responsibility in
                        OnboardingDetailRow(symbol: responsibility.symbol, text: responsibility.text, color: responsibility.color)
                    }
                }
                Spacer()
            }
            .accessibilityFocused($isFocusedOnDescription)
            .accessibilityElement(children: .combine)
            .onAppear { isFocusedOnDescription = true }
        }
    }
}

struct RoleDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        RoleDescriptionView(role: .driver)
    }
}
