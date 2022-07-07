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
                Text(vm.timerManager.isTimerRunning ? vm.timerManager.formattedTime : "START")
                    .padding()
                
                Button(action: {
                    withAnimation {       
                        if vm.timerManager.isTimerRunning {
                            vm.resetTimer()
                        } else {
                            vm.startTime()
                        }
                    }
                }, label: {
                    Image(systemName: vm.timerManager.isTimerRunning ? "pause.fill" : "play.fill")
                })
            }
            .font(.largeTitle)
            .foregroundColor(.white)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(MobSessionManager())
    }
}
