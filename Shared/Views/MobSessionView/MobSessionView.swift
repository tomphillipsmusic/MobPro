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
    @Environment(\.sizeCategory) var sizeCategory
    @State internal var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            VStack {
                
                if !vm.isKeyboardPresented {
                    if vm.isEditing {
                        ConfigureSessionView(existingConfigurations: vm.currentConfigurations)
                    } else {
                        MobTimerView(isTimerRunning: vm.mobTimer.isTimerRunning)
                    }
                    HStack {
                        infoButton
                        Spacer()
                        shuffleButton
                    }
                }
                
                VStack {
                    TeamMemberList()
                        .environment(\.editMode, $editMode)
                    
                    if vm.isEditing && sizeCategory <= .accessibilityMedium {
                        RoundedRectangleButton(label: "End Mobbing Session", color: .mobRedButtonBG) {
                            vm.showingEndSessionAlert = true
                        }
                    }
                }
                .frame(maxHeight: UIScreen.main.bounds.height * 0.4)
                
            }
            .toolbar {
                logo
                toggleSettingsButton
            }
            .alert("Are You Sure You Want to End Your Mobbing Session and Restore the Default Settings?", isPresented: $vm.showingEndSessionAlert) {
                Button("Cancel", role: .cancel) {
                    vm.showingEndSessionAlert = false
                }
                Button("End Session", role: .destructive) {
                    vm.endSession()
                }
            }
            .sheet(isPresented: $showingInfoSheet) {
                OnboardingView(firstTime: $showingInfoSheet)
            }
            .onChange(of: vm.isEditing) { _ in
                editMode.toggle()
            }
            .onAppear(perform: vm.localNotificationService.requestNotificationPermission)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                vm.movedToBackground()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                vm.movingToForeGround()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                vm.applicationTerminating()
            }
            .onReceive(NotificationCenter.default.publisher(for: .timerEndNotification)) { _ in
                vm.handleTimerEndNotification()
            }
            .animation(.spring(), value: vm.isKeyboardPresented)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MobSessionView()
            .previewDevice("iPhone 14 Plus")
            .environmentObject(MobSessionManager())
    }
}
