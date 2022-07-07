//
//  TeamMemberListRow.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct TeamMemberListRow: View {
    var teamMember: TeamMember
    @EnvironmentObject var vm: MobSessionManager
    @State private var isShowingDeleteAlert = false

    var body: some View {
        HStack {
            Text(teamMember.name)
            Spacer()
            
            SymbolButton(action: {}, symbolName: teamMember.role.symbolName, color: .blue)
            
            if vm.isEditing {
                SymbolButton(action: {
                    isShowingDeleteAlert.toggle()
                }, symbolName: "trash", color: .red)
            }
        }
        .alert("Are you sure you want to delete \(teamMember.name) from the team?", isPresented: $isShowingDeleteAlert) {
            Button("Delete", role: .destructive) {
                withAnimation {
                    vm.delete(teamMember: teamMember)
                }
            }
            Button("Cancel", role: .cancel) {
                isShowingDeleteAlert = false
            }
        }
    }
}

struct TeamMemberListRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamMemberListRow(teamMember: TeamMember(name: "Tom", role: .driver))
            .environmentObject(MobSessionManager())
    }
}
