//
//  ContentView.swift
//  Shared
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var session = MobSession()
    
    var body: some View {
        VStack {
            Text("Round \(session.currentRotationNumber) / \(session.numberOfRotationsBetweenBreaks)")
                .font(.title2)
                .bold()

            TeamMemberList(teamMembers: $session.teamMembers)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
