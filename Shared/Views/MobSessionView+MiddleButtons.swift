//
//  MobSessionView+MiddleButtons.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import SwiftUI

// MARK: Declaration of middle buttons in MobSessionView
extension MobSessionView {
    var infoButton: some View {
        SymbolButton(action: {
            showingInfoSheet = true
        }, symbolName: "info.circle", color: .mobOrange)
        .font(.title)
        .padding(.leading, 30)
    }
    
    var shuffleButton: some View {
        SymbolButton(action: {
            withAnimation {
                vm.shuffleTeam()
            }
        }, symbolName: "shuffle", color: .mobOrange)
        .disabled(vm.mobTimer.isTimerRunning)
        .font(.title)
        .padding(.trailing, 30)
    }
}
