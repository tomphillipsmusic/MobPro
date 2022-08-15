//
//  ProgressCircle.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/16/22.
//

import SwiftUI

struct ProgressCircle: View {
    var progress: Double
    var color: Color
    
    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(color, style: StrokeStyle(lineWidth: Constants.lineWidth, lineCap: .round))
            .frame(maxWidth: Constants.circleSize, maxHeight: Constants.circleSize)
            .rotationEffect(.init(degrees: -90))
    }
}
