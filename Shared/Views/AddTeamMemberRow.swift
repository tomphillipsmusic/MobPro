//
//  AddTeamMemberRow.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct AddTeamMemberRow: View {
    @EnvironmentObject var vm: MobSessionManager
    @State private var newMemberName = ""
    
    var body: some View {
        HStack {
            TextField("Add Team Member", text: $newMemberName, prompt: Text("Add member..."))
            Spacer()
                
            if !newMemberName.isEmpty {
                SymbolButton(action: addMember, symbolName: "plus", color: .mobGreen)
            }
        }
        .onReceive(keyboardPublisher) { value in
            if !newMemberName.isEmpty && !value {
                addMember()
            }
        }
    }
    
    func addMember() {
        withAnimation {
            vm.addMember(named: newMemberName)
            newMemberName = ""
        }
        
        UIApplication.shared.endEditing()
        vm.isKeyboardPresented = false
    }
}

struct AddTeamMemberRow_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamMemberRow()
            .environmentObject(MobSessionManager())
    }
}
