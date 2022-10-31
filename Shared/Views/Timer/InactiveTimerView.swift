//
//  TimerView.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct InactiveTimerView: View {
    @EnvironmentObject var vm: MobSessionManager
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(vm.isOnBreak ? .mobOrangeButtonBG : .mobGreenButtonBG)
                .frame(maxWidth: Constants.circleSize, maxHeight: Constants.circleSize)
                .padding()
                .animation(.default, value: vm.isOnBreak)
                .animation(.default, value: vm.mobTimer.isTimerRunning)
                .opacity(vm.isTeamValid ? 1 : 0.5)
                .onTapGesture {
                    if vm.isTeamValid {
                        withAnimation {
                            vm.timerTapped()
                        }
                    }
                }
            VStack {
                                
                Text(vm.timerText)
                
                Button(action: {
                    withAnimation {
                        vm.timerTapped()
                    }
                }, label: {
                    Image(systemName: "play.fill")
                })
                .disabled(!vm.isTeamValid)
            }
            .opacity(vm.isTeamValid ? 1 : 0.5)
            .font(.largeTitle)
            .foregroundColor(.white)
            
            if !vm.isTeamValid {
                Text("You need at least two Team Members")
                    .foregroundColor(.mobRed)
                    .accessibilityLabel("You need at least two Team Members. You currently have \(vm.session.teamMembers.count) in your mob.")
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(Text("Tap to begin the mob timer."))
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        InactiveTimerView()
            .environmentObject(MobSessionManager())
    }
}
