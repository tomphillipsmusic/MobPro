//
//  CircleSelector.swift
//  MobPro
//
//  Created by Tom Phillips on 7/10/22.
//

import SwiftUI

struct CircleSelector: View {
    @Binding var configuration: Configuration
    
    var body: some View {
        VStack {
            Text(configuration.label)
                .padding(.bottom, 10)
                .font(.title2)
            ZStack {
                Circle()
                    .frame(width: Constants.circleSize, height: Constants.circleSize)
                    .foregroundColor(.mobGray)
                
                ProgressCircle(progress: configuration.progress, color: Color(configuration.color))
                
                CurrentValueCircle(color: Color(configuration.color), degrees: configuration.angle)
                    .gesture(DragGesture().onChanged(onDrag(value:)))
                        .rotationEffect(.init(degrees: -90))
                
                VStack {
                    Text("\(configuration.formattedValue)")
                        .font(
                        .largeTitle)

                    if configuration.isTimeValue {
                        Text("Minutes")
                    }
                }
                .foregroundColor(Color(configuration.color))
                .font(.largeTitle)
                                
            }
            .padding()
        }
    }
    
    func onDrag(value: DragGesture.Value) {
        // Calculating radians
        
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // Eliminating drag gesture size. Since size is 55, radius is 27.5
        let radians = atan2(vector.dy - (Constants.lineWidth / 2), vector.dx - (Constants.lineWidth / 2))
        
        // Converting to angle
        
        var angle = radians * 180 / .pi
        
        // 0 to 360
        if angle < 0 {
            angle = 360 + angle
        }
        
        withAnimation(Animation.linear(duration: 0.15)) {
            
            // Progress
            let progress = angle / 360
            self.configuration.progress = progress
            self.configuration.value = configuration.formattedValue * 60
            self.configuration.angle = Double(angle)
        }
    }
}

struct CircleSelector_Previews: PreviewProvider {
    static var previews: some View {
        CircleSelector(configuration: .constant(Configuration(value: 7, maxValue: 60 * 60, isTimeValue: true, label: "Round Length", color: "MobGreen")))
    }
}
