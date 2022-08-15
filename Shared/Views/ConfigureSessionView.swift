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
    
    var leftColor: Color {
        switch selectedTab {
        case 1:
            return Color(vm.mobTimer.rotationLength.color)
        case 2:
            return Color(vm.session.numberOfRotationsBetweenBreaks.color)
        default:
            return .mobGray
        }
    }
    
    var rightColor: Color {
        switch selectedTab {
        case 0:
            return Color(vm.session.numberOfRotationsBetweenBreaks.color)
        case 1:
            return Color(vm.session.breakLengthInSeconds.color)
        default:
            return .mobGray
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    selectedTab -= 1
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.headline)
                    .foregroundColor(leftColor)
                    .padding()
            })
            .disabled(selectedTab < 1)
            
            Spacer()
            
            TabView(selection: $selectedTab) {
                CircleSelector(configuration: $vm.mobTimer.rotationLength)
                    .tag(0)
                CircleSelector(configuration: $vm.session.numberOfRotationsBetweenBreaks)
                    .tag(1)
                CircleSelector(configuration: $vm.session.breakLengthInSeconds)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Spacer()
            Button(action: {
                withAnimation {
                    selectedTab += 1
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundColor(rightColor)
                    .padding()
            })
            .disabled(selectedTab > 1)
        }
    }
}

struct ConfigureSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureSessionView()
            .environmentObject(MobSessionManager())
    }
}
