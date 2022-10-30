//
//  ConfigureSessionView.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/16/22.
//

import SwiftUI

struct ConfigureSessionView: View {
    @EnvironmentObject var vm: MobSessionManager
    @State private var selectedTab = 0
    @State private var configurations: Configurations
    
    var hasChangedConfigurations: Bool {
        configurations != vm.currentConfigurations
    }
    
    init(existingConfigurations: Configurations) {
        _configurations = State(initialValue: existingConfigurations)
    }
    
    var body: some View {
        HStack {
            ConfigurationSwipeButton(selectedTab: $selectedTab, swipeDirection: .left)
            
            Spacer()
            
            TabView(selection: $selectedTab) {
                CircleSelector(configuration: $configurations.rotationLength)
                    .tag(0)
                CircleSelector(configuration: $configurations.numberOfRotationsBetweenBreaks)
                    .tag(1)
                CircleSelector(configuration: $configurations.breakLengthInSeconds)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Spacer()
            ConfigurationSwipeButton(selectedTab: $selectedTab, swipeDirection: .right)
        }
        .onChange(of: configurations) { _ in
            vm.hasPendingEdits = hasChangedConfigurations
        }
        .toolbar {
            saveEditsButton
        }
    }
    
    var saveEditsButton: some View {
        Button(action: {
            withAnimation {
                vm.save(configurations)
            }
        }, label: {
            Text("Save")
                    .foregroundColor(.mobGreen)
                    .opacity(!vm.hasPendingEdits ? 0.5 : 1.0)
        })
        .disabled(!vm.hasPendingEdits)
    }
}

struct ConfigureSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureSessionView(existingConfigurations: .defaultValues)
            .environmentObject(MobSessionManager())
    }
}
