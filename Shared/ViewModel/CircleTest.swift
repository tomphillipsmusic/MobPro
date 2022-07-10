//
//  CircleTest.swift
//  MobPro
//
//  Created by Tom Phillips on 7/10/22.
//

import Foundation
import SwiftUI

struct CircleTest: View {
    @State private var size = UIScreen.main.bounds.width - 100
    @State private var progress: CGFloat = 0
    @State private var angle: Double = 0
    let lineWidth: CGFloat = 25.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.mobGray, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .frame(width: size, height: size)
                
                // Progress
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.mobGreen, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
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
                    .fill(Color.mobGreen)
                    .frame(width: lineWidth, height: lineWidth)
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: angle))
                    .gesture(DragGesture().onChanged(onDrag(value:)))
                    .rotationEffect(.init(degrees: -90))
                
                
                Text("\(progress)")
            }
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
            self.angle = Double(angle)
        }
    }
}

struct CircleTest_Previews: PreviewProvider {
    static var previews: some View {
        CircleTest()
    }
}
