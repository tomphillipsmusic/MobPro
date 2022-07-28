//
//  OnboardingDetailRow.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import SwiftUI

struct OnboardingDetailRow: View {
    let symbol: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 32)
                .scaledToFit()
                .padding()
                .foregroundColor(.mobYellow)
            
            Text(text)
                .foregroundColor(.mobGreen)
                .font(.body)
            
        }
    }
}
