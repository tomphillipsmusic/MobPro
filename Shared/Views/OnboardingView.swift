//
//  OnboardingView.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var firstTime: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            CloseButton()
            
            Text("Welcome to")
                .font(.largeTitle)
                .foregroundColor(.mobGreen)
                .padding()
            
            Image("MobProLogo")

            Text("A state of the art tool that helps facilitate the practice of mob programming for coders of all levels")
                .font(.headline)
                .foregroundColor(.mobYellow)
                .padding()
            
            VStack(alignment: .leading) {
                OnboardingDetailRow(symbol: "keyboard.fill", text: "Add your team members and have mobbing roles automatically assigned")
                OnboardingDetailRow(symbol: "clock.fill", text: "Customize how long your rounds are, how frequently you have breaks, and how often your breaks are")
                OnboardingDetailRow(symbol: "person.3.fill", text: "Easily adjust your mob as you go so you never have to stop coding as your mob changes")
            }
        
            RoundedRectangleButton(label: "Start Mobbing", color: .mobGreen, action: {
                firstTime = false
                dismiss()
            })
                .padding()
            
            RoundedRectangleButton(label: "Learn More", color: .mobOrange, action: {})
                .padding()
        }
    }
    
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

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(firstTime: .constant(true))
    }
}
