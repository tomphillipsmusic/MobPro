//
//  TimerCountdown.swift
//  MobPro
//
//  Created by Tom Phillips on 7/11/22.
//

import SwiftUI

struct ActiveTimerView: View {
    @EnvironmentObject var vm: MobSessionManager

    let lineWidth: CGFloat = 25.0
    
    var body: some View {
        VStack {

            ZStack {
                Circle()
                    .frame(maxWidth: Constants.circleSize, maxHeight: Constants.circleSize)
                    .foregroundColor(.mobGray)
                    .onTapGesture {
                        withAnimation {
                            if !vm.isOnBreak {
                                vm.timerTapped()
                            }
                        }
                    }
                
                ProgressCircle(progress: vm.mobTimer.timerProgress, color: vm.mobTimer.color)
                    .animation(.linear, value: vm.mobTimer.timeRemaining)
                
                CurrentValueCircle(color: vm.mobTimer.color, degrees: vm.mobTimer.degrees)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: vm.mobTimer.timeRemaining)

                VStack {
                    
                    if vm.isOnBreak {
                        Text("BREAK")
                    }
                    
                    Text("\(vm.timerText)")
                        .font(
                        .largeTitle)
                    
                    if !vm.isOnBreak {
                        Button(action: {
                            withAnimation {
                                vm.timerTapped()
                            }
                        }, label: {
                            Image(systemName: "pause.fill")
                        })
                    }
                }
                .foregroundColor(vm.mobTimer.color)
                .font(.largeTitle)
                                
            }
            .padding()
        }
    }
}



struct TimerCountdown_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTimerView()
            .environmentObject(MobSessionManager())

    }
}
