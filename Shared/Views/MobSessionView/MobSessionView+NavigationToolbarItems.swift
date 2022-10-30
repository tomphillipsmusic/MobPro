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
    
    var trailingNavigationToolbarItem: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            if !vm.isEditing {
                toggleSettingsButton
            }
        }
    }
    
    var toggleSettingsButton: some View {
        Button(action: {
            withAnimation {
//                if editMode == .inactive {
//                    editMode = .active
//                } else if editMode == .active{
//                    editMode = .inactive
//                }
                vm.isEditing.toggle()
            }
        }, label: {
            Image(systemName: "gear")
                .foregroundColor(.mobOrange)
                .font(.title3)
                .opacity(vm.mobTimer.isTimerRunning ? 0.5 : 1.0)
            
        })
        .disabled(vm.mobTimer.isTimerRunning)
    }
    
//    fileprivate var saveEditsButton: some View {
//        Button(action: {
//            withAnimation {
//                if editMode == .inactive {
//                    editMode = .active
//                } else if editMode == .active{
//                    editMode = .inactive
//                }
//                vm.isEditing.toggle()
//            }
//        }, label: {
//            Text("Save")
//                    .foregroundColor(.mobGreen)
//                    .opacity(!vm.hasPendingEdits ? 0.5 : 1.0)
//        })
//        .disabled(!vm.hasPendingEdits)
//    }
    
    var cancelEditingButton: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarLeading) {
            if vm.isEditing {
                Button(action: {
                    withAnimation {
                        //editMode = .inactive
                        vm.isEditing.toggle()
                        vm.hasPendingEdits = false
                    }
                }, label: {
                    if vm.isEditing {
                        Text("Cancel")
                            .foregroundColor(.mobYellow)
                    }
                    
                })
            }
        }
    }
}
