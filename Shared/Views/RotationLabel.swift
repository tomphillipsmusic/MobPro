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
        Text("Rotation \(vm.currentRotationNumber) / \(vm.session.numberOfRotationsBetweenBreaks)")
            .font(.title2)
            .bold()
    }
}

struct RotationLabel_Previews: PreviewProvider {
    static var previews: some View {
        RotationLabel()
            .environmentObject(MobSessionManager())
    }
}


