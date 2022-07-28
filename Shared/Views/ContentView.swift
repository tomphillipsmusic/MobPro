//
//  ContentView.swift
//  Shared
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("firstTimeUser") var showingInfoSheet = true
    @EnvironmentObject var vm: MobSessionManager
    @State private var editMode = EditMode.inactive
    @State private var showingEndSessionAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if !vm.isKeyboardPresented {
                    if vm.isEditing {
                        ConfigureSessionView()
                    } else {
                        RotationLabel()
                        if vm.mobTimer.isTimerRunning {
                            TimerCountdown()
                        } else {
                            TimerView()
                        }
                    }
                    HStack {
                        infoButton
                        Spacer()
                        
                        if !vm.mobTimer.isTimerRunning {
                            shuffleButton
                        }
                    }
                }
                
                TeamMemberList()
                    .environment(\.editMode, $editMode)
                
                if vm.isEditing {
                    RoundedRectangleButton(label: "End Mobbing Session", color: .mobRed) {
                        showingEndSessionAlert = true
                    }
                    .padding()
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
            .onAppear(perform: vm.requestPermission)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                vm.movedToBackground()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                vm.movingToForeGround()
            }
            .onReceive(keyboardPublisher) { value in
                vm.isKeyboardPresented = value
            }
            .animation(.spring(), value: vm.isKeyboardPresented)
        }
    }
    
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
        .font(.title)
        .padding(.trailing, 30)
    }
}

// MARK: Navigation Toolbar Items
extension ContentView {
    var logo: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Image("MobProLogo")
        }
    }
    
    var toggleSettingsButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                withAnimation {
                    if editMode == .inactive {
                        editMode = .active
                    } else if editMode == .active{
                        editMode = .inactive
                    }
                    vm.isEditing.toggle()
                }
            }, label: {
                if vm.isEditing {
                    Text("Save")
                        .foregroundColor(.mobGreen)
                } else {
                    Image(systemName: "gear")
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MobSessionManager())
    }
}
