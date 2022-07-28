//
//  RoundedRectangleButton.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/16/22.
//

import SwiftUI

struct RoundedRectangleButton: View {
    let label: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .frame(minWidth: 20, maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Rectangle().fill(color))
                .padding()
                .shadow(radius: 3.0)
        }
    }
}

struct RoundedRectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleButton(label: "End Mob Session", color: .mobRed, action: {})
    }
}
