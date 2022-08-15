//
//  ConfigureSessionView.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/16/22.
//

import SwiftUI

struct ConfigureSessionView: View {
    @EnvironmentObject var vm: MobSessionManager
    @State private var selectedTab = 0
    
    var body: some View {
        HStack {
            ConfigurationSwipeButton(selectedTab: $selectedTab, swipeDirection: .left)
            
            Spacer()
            
            TabView(selection: $selectedTab) {
                CircleSelector(configuration: $vm.mobTimer.rotationLength)
                    .tag(0)
                CircleSelector(configuration: $vm.session.numberOfRotationsBetweenBreaks)
                    .tag(1)
                CircleSelector(configuration: $vm.session.breakLengthInSeconds)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Spacer()
            ConfigurationSwipeButton(selectedTab: $selectedTab, swipeDirection: .right)
        }
    }
}

struct ConfigureSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureSessionView()
            .environmentObject(MobSessionManager())
    }
}
