//
//  HapticsManager.swift
//  MobPro
//
//  Created by Tom Phillips on 8/6/22.
//

import CoreHaptics
import AudioToolbox

class HapticsManager {
    static let shared = HapticsManager()
    private var engine: CHHapticEngine?
    
    private init() {
        prepareHaptics()
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Unable to start haptics engine. \(error.localizedDescription)")
        }
    }
    
    func configurationValueChange(progress: Float) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
                    
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: progress > 0.25 ? progress : progress + 0.1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let attackTime = CHHapticEventParameter(parameterID: .attackTime, value: 0.1)
        let decayTime = CHHapticEventParameter(parameterID: .decayTime, value: 0.1)

        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness, attackTime, decayTime], relativeTime: 0)
        
        do {
                   let pattern = try CHHapticPattern(events: [event], parameters: [])
                   let player = try engine?.makePlayer(with: pattern)
                   try player?.start(atTime: 0)
               } catch {
                   print("Failed to play pattern: \(error.localizedDescription)")
               }
    }
    
    func timerEnd() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }

        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
    }
    
    func buttonTapped() {
        
    }
}
