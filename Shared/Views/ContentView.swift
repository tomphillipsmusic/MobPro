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
                TimerView()
                HStack {
                    Spacer()
                    
                    shuffleButton
                }
                
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
    
    var shuffleButton: some View {
        SymbolButton(action: {
            withAnimation {
                vm.shuffleTeam()
            }
        }, symbolName: "shuffle", color: .mobOrange)
            .font(.title)
            .padding(.trailing, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MobSessionManager())
    }
}
