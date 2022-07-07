//
//  ContentView.swift
//  Shared
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: MobSessionManager
    
    var body: some View {
        NavigationView {
            VStack {
                RotationLabel(session: vm.session)
                TeamMemberList()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("MobProLogo")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            vm.isEditing.toggle()
                        }
                    }, label: {
                        Image(systemName: "gear")
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MobSessionManager())
    }
}
