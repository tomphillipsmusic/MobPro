//
//  CircleSelector.swift
//  MobPro
//
//  Created by Tom Phillips on 7/10/22.
//

import SwiftUI

struct CircleSelector: View {
    @Binding var configuration: Configuration
    @State private var size = UIScreen.main.bounds.width - 120
    @State private var progress: CGFloat
    @State private var angle: Double
    
    var minutes: Int {
        Int(progress * CGFloat(configuration.maxValue)) / 60
    }

    let lineWidth: CGFloat = 25.0
    
    init(configuration: Binding<Configuration>) {
        _configuration = configuration
        let progress = CGFloat(configuration.wrappedValue.value) / CGFloat(configuration.wrappedValue.maxValue)
        _progress = State(initialValue: progress)
        _angle = State(initialValue: Double(progress * Double(360)))

    }
    
    var body: some View {
        VStack {
            Text(configuration.label)
                .padding(.bottom, 10)
                .font(.title2)
            ZStack {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(.mobGray)
                Circle()
                    .stroke(Color.mobGray, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .frame(width: size, height: size)
                
                // Progress
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color(configuration.color), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .frame(width: size, height: size)
                    .rotationEffect(.init(degrees: -90))
                
                // Inner Finish Curve
//                Circle()
//                    .fill(Color.white)
//                    .frame(width: 55, height: 55)
//                    .offset(x: size / 2)
//                    .rotationEffect(.init(degrees: -90))
                
                //Drag Circle
                Circle()
                    .fill(Color(configuration.color))
                    .frame(width: lineWidth * 2, height: lineWidth * 2)
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: angle))
                    .gesture(DragGesture().onChanged(onDrag(value:)))
                    .rotationEffect(.init(degrees: -90))
                
                
                VStack {
                    Text("\(minutes)")
                        .font(
                        .largeTitle)

// DEBUG Only                    Text("\(configuration.value)")

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
        let radians = atan2(vector.dy - (lineWidth / 2), vector.dx - (lineWidth / 2))
        
        // Converting to angle
        
        var angle = radians * 180 / .pi
        
        // 0 to 360
        if angle < 0 {
            angle = 360 + angle
        }
        
        withAnimation(Animation.linear(duration: 0.15)) {
            
            // Progress
            let progress = angle / 360
            self.progress = progress
            self.configuration.value = Int(progress * CGFloat(configuration.maxValue)) / 60
            self.angle = Double(angle)
        }
    }
}

struct CircleSelector_Previews: PreviewProvider {
    static var previews: some View {
        CircleSelector(configuration: .constant(Configuration(value: 7, maxValue: 60 * 60, isTimeValue: true, label: "Round Length", color: "MobGreen")))
    }
}
