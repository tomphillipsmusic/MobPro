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
    @State private var isShowingRoleDescription = false

    var body: some View {
        HStack {
            Text(teamMember.name)
                .accessibilityHidden(true)
            Spacer()
            
            SymbolButton(action: {
                isShowingRoleDescription.toggle()
            }, symbolName: teamMember.role.symbolName, color: teamMember.role.color, accessibilityLabel: teamMember.description, accessibilityHint: "Tap to learn more about the responsibilities of the \(teamMember.role.rawValue) role.")
        }
        .popover(isPresented: $isShowingRoleDescription) {
            RoleDescriptionView(role: teamMember.role)
        }
    }
}

struct TeamMemberListRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamMemberListRow(teamMember: TeamMember(name: "Tom", role: .driver))
            .environmentObject(MobSessionManager())
    }
}
