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
        VStack {
            Text("\(configuration.voiceOverValue) \(configuration.isTimeValue ? "Minutes" : "")")

            Button("Increment") {
                configuration.value += 60
            }

            Button("Decrement") {
                configuration.value -= 60
            }
        }
        .accessibilityElement()
        .accessibilityLabel(configuration.label)
        .accessibilityValue("\(configuration.voiceOverValue) \(configuration.isTimeValue ? "Minutes" : "")")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if configuration.value + 60 <= configuration.maxValue {
                    configuration.value += 60
                }
            case .decrement:
                if configuration.value - 60 >= 60 {
                    configuration.value -= 60
                }
            default:
                print("Not handled.")
            }
        }
    }
}

struct ConfigurationStepper_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationStepper(configuration: .constant(.defaultRotationLength))
    }
}
