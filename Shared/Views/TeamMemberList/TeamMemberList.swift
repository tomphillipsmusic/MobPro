//
//  TeamMemberList.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct TeamMemberList: View {
    @EnvironmentObject var vm: MobSessionManager
    
    var body: some View {
        List {
            Section(content:  {
                ForEach(vm.session.teamMembers) { teamMember in
                    TeamMemberListRow(teamMember: teamMember)
                }
                .onMove(perform: move)
                .onDelete(perform: vm.delete)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                
                AddTeamMemberRow()
            }, header: {
                Text("Team Members")
                    .font(.headline)
                
            })
        }
        .listStyle(.plain)
        .animation(.default, value: vm.session.teamMembers)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        vm.moveTeamMember(from: source, to: destination)
    }
}

struct TeamMemberList_Previews: PreviewProvider {
    static var previews: some View {
        TeamMemberList()
            .environmentObject(MobSessionManager())
    }
}
