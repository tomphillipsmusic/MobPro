//
//  TimerView.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct InactiveTimerView: View {
    @EnvironmentObject var vm: MobSessionManager
    
    var accessibilityLabel: String {
        "\(vm.timerText). \(!vm.isTeamValid ? "You need at least two Team Members. You currently have \(vm.session.teamMembers.count) in your mob." : "")"
    }
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(vm.isOnBreak ? .mobOrangeButtonBG : .mobGreenButtonBG)
                .frame(maxWidth: Constants.circleSize, maxHeight: Constants.circleSize)
                .padding()
                .animation(.default, value: vm.isOnBreak)
                .animation(.default, value: vm.mobTimer.isTimerRunning)
                .opacity(vm.isTeamValid ? 1 : 0.5)
                .accessibilityHidden(true)
                .onTapGesture {
                    if vm.isTeamValid {
                        withAnimation {
                            vm.timerTapped()
                        }
                    }
                }
            VStack {
                                
                Text(vm.timerText)
                    .accessibilityHidden(true)
                
                Button(action: {
                    withAnimation {
                        vm.timerTapped()
                    }
                }, label: {
                    Image(systemName: "play.fill")
                })
                .disabled(!vm.isTeamValid)
                .accessibilityLabel(Text(accessibilityLabel))
                .accessibilityHint(Text("Tap to begin the mob timer.)" ))
            }
            .opacity(vm.isTeamValid ? 1 : 0.5)
            .font(.largeTitle)
            .foregroundColor(.white)
            
            if !vm.isTeamValid {
                Text("You need at least two Team Members")
                    .foregroundColor(.mobRed)
                    .accessibilityLabel("You need at least two Team Members. You currently have \(vm.session.teamMembers.count) in your mob.")
                    .accessibilityHidden(true)
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        InactiveTimerView()
            .environmentObject(MobSessionManager())
    }
}
