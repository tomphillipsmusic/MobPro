//
//  MobSessionView+NavigationToolbarItems.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import SwiftUI

// MARK: Navigation Toolbar Items
extension MobSessionView {
    
    var logo: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Image(decorative: "MobProLogo")
                .resizable()
                .scaledToFit()
                .padding(5)
        }
    }
    
    var toggleSettingsButton: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            if !vm.isEditing {
                Button(action: {
                    withAnimation {
                        vm.isEditing.toggle()
                    }
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.mobOrange)
                        .font(.title3)
                        .opacity(vm.mobTimer.isTimerRunning ? 0.5 : 1.0)
                        .accessibilityHint(Text("Tap to configure the mob session and team members."))
                    
                })
                .disabled(vm.mobTimer.isTimerRunning)
            }
        }
    }


}
