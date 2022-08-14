//
//  ContentView.swift
//  Shared
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct MobSessionView: View {
    @AppStorage("firstTimeUser") var showingInfoSheet = true
    @EnvironmentObject var vm: MobSessionManager
    @State internal var editMode = EditMode.inactive
    @State private var showingEndSessionAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if !vm.isKeyboardPresented {
                    if vm.isEditing {
                        ConfigureSessionView()
                    } else {
                        MobTimerView(isTimerRunning: vm.mobTimer.isTimerRunning)
                    }
                    HStack {
                        infoButton
                        Spacer()
                        shuffleButton
                    }
                }
                
                TeamMemberList()
                    .environment(\.editMode, $editMode)
                
                if vm.isEditing {
                    RoundedRectangleButton(label: "End Mobbing Session", color: .mobRedButtonBG) {
                        showingEndSessionAlert = true
                    }
                }
            }
            .toolbar {
                logo
                toggleSettingsButton
            }
            .alert("Are You Sure You Want to End Your Mobbing Session?", isPresented: $showingEndSessionAlert) {
                Button("Cancel", role: .cancel) {
                    showingEndSessionAlert = false
                }
                Button("End Session", role: .destructive) {
                    vm.endSession()
                }
            }
            .sheet(isPresented: $showingInfoSheet) {
                OnboardingView(firstTime: $showingInfoSheet)
            }
            .onAppear(perform: vm.requestNotificationPermission)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                vm.movedToBackground()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                vm.movingToForeGround()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                vm.applicationTerminating()
            }
            .onReceive(keyboardPublisher) { value in
                vm.isKeyboardPresented = value
            }
            .animation(.spring(), value: vm.isKeyboardPresented)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MobSessionView()
            .environmentObject(MobSessionManager())
    }
}
