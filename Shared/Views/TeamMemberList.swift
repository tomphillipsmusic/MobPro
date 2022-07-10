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
                .onDelete(perform: vm.delete)
                
                AddTeamMemberRow()
            }, header: {
                Text("Team Members")
                    .font(.headline)
                
            })
        }
        .listStyle(.plain)
        .animation(.default, value: vm.session.teamMembers)
    }
}

struct TeamMemberList_Previews: PreviewProvider {
    static var previews: some View {
        TeamMemberList()
            .environmentObject(MobSessionManager())
    }
}
