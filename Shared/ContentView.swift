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

            List {
                Section(content:  {
                    ForEach(session.teamMembers) { teamMember in
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
                }, header: {
                        Text("Team Members")
                            .font(.headline)
                })
            }
            .listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
