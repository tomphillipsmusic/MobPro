//
//  RotationLabel.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct RotationLabel: View {
    var session: MobSession
    
    var body: some View {
        Text("Rotation \(session.currentRotationNumber) / \(session.numberOfRotationsBetweenBreaks)")
            .font(.title2)
            .bold()
    }
}

struct RotationLabel_Previews: PreviewProvider {
    static var previews: some View {
        RotationLabel(session: MobSession())
    }
}


