//
//  ConfigurationStepper.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 10/31/22.
//

import SwiftUI

struct ConfigurationStepper: View {
    @Binding var configuration: Configuration
    var body: some View {
        HStack {
            Text("\(configuration.label): \(configuration.formattedValue) \(configuration.isTimeValue ? "Minutes" : "")")
            
            Button(action: increment, label: {
                Image(systemName: "arrow.up")
                    .accessibilityLabel(Text("Increment"))
            })
            
           Button(action: decrement, label: {
               Image(systemName: "arrow.down")
                   .accessibilityLabel(Text("Decrement"))
           })
        }
        .padding()
        .accessibilityElement()
        .accessibilityLabel(configuration.label)
        .accessibilityValue("\(configuration.formattedValue) \(configuration.isTimeValue ? "Minutes" : "")")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                increment()
            case .decrement:
               decrement()
            default:
                print("Not handled.")
            }
        }
    }
    
    func increment() {
        if configuration.value <= configuration.maxValue - 120 {
            configuration.value += 60
            configuration.progress = Double(configuration.value) / Double(configuration.maxValue)
            configuration.angle = Double(configuration.progress * Double(360))
        }
    }
    
    func decrement() {
        if configuration.value - 60 >= 0 {
            configuration.value -= 60
            configuration.progress = Double(configuration.value) / Double(configuration.maxValue)
            configuration.angle = Double(configuration.progress * Double(360))
        }
    }
}

struct ConfigurationStepper_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationStepper(configuration: .constant(.defaultRotationLength))
    }
}
