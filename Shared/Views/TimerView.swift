//
//  TimerView.swift
//  MobPro
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var vm: MobSessionManager
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.mobGreen)
                .padding()
            VStack {
                Text(vm.mobTimer.isTimerRunning ? vm.mobTimer.formattedTime : "START")
                    .padding()
                
                Button(action: {
                    withAnimation {       
                        if vm.mobTimer.isTimerRunning {
                            vm.resetTimer()
                        } else {
                            vm.startTime()
                        }
                    }
                }, label: {
                    Image(systemName: vm.mobTimer.isTimerRunning ? "pause.fill" : "play.fill")
                })
            }
            .font(.largeTitle)
            .foregroundColor(.white)
        }
        .onReceive(vm.$currentRotationNumber) { _ in
            withAnimation {
                DispatchQueue.main.async {
                    vm.shiftTeam()
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(MobSessionManager())
    }
}
