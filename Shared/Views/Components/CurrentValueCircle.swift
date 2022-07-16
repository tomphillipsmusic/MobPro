//
//  CurrentValueCircle.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/16/22.
//

import SwiftUI

struct CurrentValueCircle: View {
    let color: Color
    let degrees: Double

    var body: some View {
        Circle()
            .fill((color))
            .frame(width: Constants.lineWidth * 2, height: Constants.lineWidth * 1.5)
            .offset(x: Constants.circleSize / 2)
            .rotationEffect(.init(degrees: degrees))
    }
}
