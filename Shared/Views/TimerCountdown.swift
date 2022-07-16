//
//  TimerCountdown.swift
//  MobPro
//
//  Created by Tom Phillips on 7/11/22.
//

import SwiftUI

struct TimerCountdown: View {
    @EnvironmentObject var vm: MobSessionManager
    @State private var size = UIScreen.main.bounds.width - 120

    let lineWidth: CGFloat = 25.0
    
    
    var timerColor: Color {
        let timeRemaining = Double(vm.mobTimer.timeRemaining)
        let rotationLength = Double(vm.mobTimer.rotationLength.value)
        if timeRemaining >= rotationLength * 0.8 {
            return .mobGreen
        } else if timeRemaining >= rotationLength * 0.6 {
            return .mobYellowGreen
        } else if timeRemaining >= rotationLength * 0.4 {
            return .mobYellow
        } else if timeRemaining >= rotationLength * 0.2 {
            return .mobOrange
        } else {
            return .mobRed
        }
    }
    
    var body: some View {
        VStack {

            ZStack {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(.mobGray)
                Circle()
                    .stroke(Color.mobGray, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .frame(width: size, height: size)
                
                // Progress
                Circle()
                    .trim(from: 0, to: CGFloat(CGFloat(vm.mobTimer.timeRemaining) / CGFloat(vm.mobTimer.rotationLength.value)))
                    .stroke(timerColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .frame(width: size, height: size)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: vm.mobTimer.timeRemaining)
                
                Circle()
                    .fill((timerColor))
                    .frame(width: lineWidth * 2, height: lineWidth * 1.5)
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: Double((Double(vm.mobTimer.timeRemaining) / Double(vm.mobTimer.rotationLength.value)) * 360.0)))
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: vm.mobTimer.timeRemaining)

                
                
                VStack {
                    
                    if vm.isOnBreak {
                        Text("BREAK")
                    }
                    
                    Text("\(vm.timerText)")
                        .font(
                        .largeTitle)
                        .padding()
                   
                    
                    if !vm.isOnBreak {
                        Button(action: {
                            withAnimation {
                                vm.timerTapped()
                            }
                        }, label: {
                            Image(systemName: vm.mobTimer.isTimerRunning ? "pause.fill" : "play.fill")
                        })
                    }
                }
                .foregroundColor(timerColor)
                .font(.largeTitle)
                                
            }
            .padding()
//            Text("Time Remaining: \(vm.mobTimer.timeRemaining)")
//            Text("Rotation Length: \(vm.mobTimer.rotationLength.value)")
//
//            Text("Progress: \(CGFloat(vm.mobTimer.timeRemaining / vm.mobTimer.rotationLength.value))")
//            Text("Angle: \(Double((vm.mobTimer.timeRemaining / vm.mobTimer.rotationLength.value) * 360))")
        }
    }
}
struct TimerCountdown_Previews: PreviewProvider {
    static var previews: some View {
        TimerCountdown()
            .environmentObject(MobSessionManager())

    }
}
