//
//  ConfigureSessionView.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/16/22.
//

import SwiftUI

struct ConfigureSessionView: View {
    @EnvironmentObject var vm: MobSessionManager

    var body: some View {
        TabView {
            CircleSelector(configuration: $vm.mobTimer.rotationLength)
            CircleSelector(configuration: $vm.session.numberOfRotationsBetweenBreaks)
            CircleSelector(configuration: $vm.session.breakLengthInSeconds)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct ConfigureSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureSessionView()
            .environmentObject(MobSessionManager())
    }
}
