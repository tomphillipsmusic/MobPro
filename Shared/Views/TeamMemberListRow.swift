//
//  TeamMemberListRow.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct TeamMemberListRow: View {
    var teamMember: TeamMember
    
    var body: some View {
        HStack {
            Text(teamMember.name)
            Spacer()
            
            SymbolButton(action: {}, symbolName: teamMember.role.symbolName, color: .blue)
            
        }
    }
}

struct TeamMemberListRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamMemberListRow(teamMember: TeamMember(name: "Tom", role: .driver))
    }
}
