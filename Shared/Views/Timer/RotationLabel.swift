//
//  RotationLabel.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct RotationLabel: View {
    @EnvironmentObject var vm: MobSessionManager
    
    var body: some View {
        if !vm.isOnBreak {
            Text("Rotation \(vm.currentRotationNumber) / \(vm.numberOfRoundsBeforeBreak)")
                .font(.title2)
                .bold()
                .accessibilityLabel(Text("Rotation \(vm.currentRotationNumber) of \(vm.numberOfRoundsBeforeBreak)"))
        }
    }
}

struct RotationLabel_Previews: PreviewProvider {
    static var previews: some View {
        RotationLabel()
            .environmentObject(MobSessionManager())
    }
}


