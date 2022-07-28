//
//  MobTimerView.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import SwiftUI

struct MobTimerView: View {
    let isTimerRunning: Bool
    
    var body: some View {
        VStack {
            RotationLabel()
            
            if isTimerRunning {
                ActiveTimerView()
            } else {
                InactiveTimerView()
            }
        }
    }
    
    struct MobTimerView_Previews: PreviewProvider {
        static var previews: some View {
            MobTimerView(isTimerRunning: false)
                .environmentObject(MobSessionManager())
        }
    }
}
