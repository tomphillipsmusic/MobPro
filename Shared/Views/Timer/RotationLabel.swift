//
//  RotationLabel.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct RotationLabel: View {
    @EnvironmentObject var vm: MobSessionManager
    @AccessibilityFocusState var isFocusedOnRotationLabel: Bool
    
    var body: some View {
        if !vm.isOnBreak {
            Text("Rotation \(vm.currentRotationNumber) / \(vm.numberOfRoundsBeforeBreak)")
                .font(.title2)
                .bold()
                .accessibilityLabel(Text("Rotation \(vm.currentRotationNumber) of \(vm.numberOfRoundsBeforeBreak)"))
                .accessibilityFocused($isFocusedOnRotationLabel)
                .onChange(of: vm.currentRotationNumber) { _ in
                    isFocusedOnRotationLabel = true
                }
        }
    }
}

struct RotationLabel_Previews: PreviewProvider {
    static var previews: some View {
        RotationLabel()
            .environmentObject(MobSessionManager())
    }
}


