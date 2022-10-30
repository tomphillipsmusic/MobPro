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
    @State private var configurations: Configurations
    /* pass in an initial configuration
        - when saving check to see if anything has changed
     
        - if something has changed reset round back to 1
     
        - if nothing has changed
     
        - cancel button in left corner if nothign is changed
     
        - save button only pressed if something has changed
     */
    
    var hasChangedConfigurations: Bool {
        configurations != vm.currentConfigurations
    }
    
    init(existingConfigurations: Configurations) {
        _configurations = State(initialValue: existingConfigurations)
    }
    
    var body: some View {
        HStack {
            ConfigurationSwipeButton(selectedTab: $selectedTab, swipeDirection: .left)
            
            Spacer()
            
            TabView(selection: $selectedTab) {
                CircleSelector(configuration: $configurations.rotationLength)
                    .tag(0)
                CircleSelector(configuration: $configurations.numberOfRotationsBetweenBreaks)
                    .tag(1)
                CircleSelector(configuration: $configurations.breakLengthInSeconds)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Spacer()
            ConfigurationSwipeButton(selectedTab: $selectedTab, swipeDirection: .right)
        }
        .onChange(of: configurations) { _ in
            vm.hasPendingEdits = hasChangedConfigurations
        }
    }
}

struct ConfigureSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureSessionView(existingConfigurations: .defaultValues)
            .environmentObject(MobSessionManager())
    }
}
