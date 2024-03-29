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
            VStack {
                Text("Welcome to")
                    .font(.largeTitle)
                    .foregroundColor(.mobGreen)
                    .padding()
                    .accessibilityLabel(Text("Welcome to MobPro."))
                
                Image(decorative: "MobProLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 5)
                    .padding(.horizontal, 60)

                Text("A state of the art tool that helps facilitate the practice of mob programming for coders of all levels")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding()
                
                VStack(alignment: .leading) {
                    OnboardingDetailRow(symbol: "keyboard.fill", text: "Add your team members and have mobbing roles automatically assigned", color: .mobYellowGreen)
                    OnboardingDetailRow(symbol: "clock.fill", text: "Customize how long your rounds are, how frequently you have breaks, and how often your breaks are", color: .mobYellowGreen)
                    OnboardingDetailRow(symbol: "person.3.fill", text: "Easily adjust your mob as you go so you never have to stop coding as your mob changes", color: .mobYellowGreen)
                }
            }
            .accessibilityElement(children: .combine)
        
            RoundedRectangleButton(label: "Start Mobbing", color: .mobGreenButtonBG, action: {
                firstTime = false
                dismiss()
            })
            
            Link(destination: URL(string: "https://www.pluralsight.com/blog/software-development/mob-programming-101")!, label: {
                Text("Learn More")
                    .frame(minWidth: 20, maxWidth: .infinity)
                    .foregroundColor(.mobYellow)
                    .padding()
                    .accessibilityHint(Text("Tap to open a link to a web resource that goes more into depth about the benefits of mob programming."))
            })
        }
        .largeTextScrollView()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(firstTime: .constant(true))
    }
}
