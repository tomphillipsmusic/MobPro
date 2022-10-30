//
//  Configuration.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 10/29/22.
//

import Foundation

struct Configurations: Codable {
    var rotationLength: Configuration
    var breakLengthInSeconds: Configuration
    var numberOfRotationsBetweenBreaks: Configuration
}

struct Configuration: Identifiable, Codable {
    var id = UUID()
    var value: Int
    let maxValue: Int
    let isTimeValue: Bool
    let label: String
    let color: String
    var progress: Double = 0
    var angle: Double
    
    var formattedValue: Int {
        (Int(progress * Double(maxValue)) / 60) + 1
    }
    
    init(value: Int, maxValue: Int, isTimeValue: Bool, label: String, color: String) {
        self.value = value
        self.maxValue = maxValue
        self.isTimeValue = isTimeValue
        self.label = label
        self.color = color
        progress = Double(value) / Double(maxValue)
        angle = Double(progress * Double(360))
    }
}

// MARK: Equatable Conformance

extension Configurations: Equatable {}
extension Configuration: Equatable {
//    static func == (lhs: Configuration, rhs: Configuration) -> Bool {
//        lhs.
//       }
}

// MARK: Default Configurations
extension Configurations {
    static let defaultValues = Configurations(rotationLength: .defaultRotationLength, breakLengthInSeconds: .defaulBreakLengthInSeconds, numberOfRotationsBetweenBreaks: .defaultNumberOfRotationsBetweenBreaks)
}

// MARK: Default Configuration Values
extension Configuration {
    static let defaultRotationLength = Configuration(value: 6 * Constants.secondsPerMinute, maxValue: 60 * Constants.secondsPerMinute, isTimeValue: true, label: "Round Length", color: "MobGreen")
    
    static let defaulBreakLengthInSeconds = Configuration(value: 5 * 60, maxValue: 60 * 30, isTimeValue: true, label: "Break Length", color: "MobOrange")
    
    static let defaultNumberOfRotationsBetweenBreaks = Configuration(value: 5 * 60, maxValue: 10 * 60, isTimeValue: false, label: "Rounds Between Breaks", color: "MobYellowGreen")
}
