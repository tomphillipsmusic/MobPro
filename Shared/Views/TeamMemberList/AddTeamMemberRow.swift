//
//  AddTeamMemberRow.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct AddTeamMemberRow: View, KeyboardReadable {
    @EnvironmentObject var vm: MobSessionManager
    @State private var newMemberName = ""
    
    var body: some View {
        HStack {
            TextField("Add Team Member", text: $newMemberName, prompt: Text("Add member..."))
                .onSubmit {
                    if !newMemberName.isEmpty {
                        addMember()
                        UIApplication.shared.endEditing()
                        vm.isKeyboardPresented = false
                    }
                }
                
            
            Spacer()
                
            if !newMemberName.isEmpty {
                SymbolButton(action: addMember, symbolName: "plus", color: .mobGreen)
            }
        }
        .onReceive(keyboardPublisher) { isKeyboardVisible in
            vm.isKeyboardPresented = isKeyboardVisible
        }
    }
    
    func addMember() {
        withAnimation {
            vm.addMember(named: newMemberName)
            newMemberName = ""
        }
    }
}

struct AddTeamMemberRow_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamMemberRow()
            .environmentObject(MobSessionManager())
    }
}
