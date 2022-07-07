//
//  TeamMemberList.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct TeamMemberList: View {
    @Binding var teamMembers: [TeamMember]
    @State private var newMemberName = ""
    
    var body: some View {
        List {
            Section(content:  {
                ForEach(teamMembers) { teamMember in
                    HStack {
                        Text(teamMember.name)
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: teamMember.role.symbolName)
                                .foregroundColor(.blue)
                                .frame(width: 30, height: 30, alignment: .center)
                        })
                        
                    }
                }
                
                HStack {
                    TextField("Add Team Member", text: $newMemberName, prompt: Text("Add member..."))
                    Spacer()
                        
                    if !newMemberName.isEmpty {
                        Button(action: addMember, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.green)
                                .frame(width: 30, height: 30, alignment: .center)
                        })
                    }
                }
            }, header: {
                Text("Team Members")
                    .font(.headline)
                
            })
        }
        .listStyle(.plain)
    }
    
    func addMember() {
        let memberToAdd = TeamMember(name: newMemberName, role: .researcher)
        teamMembers.append(memberToAdd)
    }
}

struct TeamMemberList_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamMemberList(teamMembers: .constant(MobSession.sampleTeam))
    }
}
