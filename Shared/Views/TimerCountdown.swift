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
                    .stroke(Color.mobGreen, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .frame(width: size, height: size)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: vm.mobTimer.timeRemaining)
                
                Circle()
                    .fill((Color.mobGreen))
                    .frame(width: lineWidth * 2, height: lineWidth * 1.5)
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: Double((Double(vm.mobTimer.timeRemaining) / Double(vm.mobTimer.rotationLength.value)) * 360.0)))
                    .rotationEffect(.init(degrees: -90))
                    .animation(.linear, value: vm.mobTimer.timeRemaining)

                
                
                VStack {
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
                .foregroundColor(.mobGreen)
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
