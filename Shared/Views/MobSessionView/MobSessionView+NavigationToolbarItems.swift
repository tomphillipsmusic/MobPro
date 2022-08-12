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
            Image("MobProLogo")
                .resizable()
                .scaledToFit()
                .padding(5)
        }
    }
    
    var toggleSettingsButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                withAnimation {
                    if editMode == .inactive {
                        editMode = .active
                    } else if editMode == .active{
                        editMode = .inactive
                    }
                    vm.isEditing.toggle()
                }
            }, label: {
                if vm.isEditing {
                    Text("Save")
                        .foregroundColor(.mobGreen)
                } else {
                    Image(systemName: "gear")
                        .foregroundColor(.mobOrange)
                        .font(.title3)
                        .opacity(vm.mobTimer.isTimerRunning ? 0.6 : 1.0)
                }
            })
            .disabled(vm.mobTimer.isTimerRunning)
            .hapticFeedbackOnTap(style: .heavy)
        }
    }
}
