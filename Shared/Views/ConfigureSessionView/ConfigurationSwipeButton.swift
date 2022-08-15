//
//  ConfigurationSwipeButton.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 8/14/22.
//

import SwiftUI

struct ConfigurationSwipeButton: View {
    @EnvironmentObject var vm: MobSessionManager
    @Binding var selectedTab: Int
    let swipeDirection: SwipeDirection
    
    var body: some View {
        Button(action: {
            withAnimation {
                switchConfiguration()
            }
        }, label: {
            Image(systemName: imageName)
                .font(.headline)
                .foregroundColor(color)
                .padding()
        })
        .disabled(isDisabled)
    }
}

struct ConfigurationSwipeButton_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSwipeButton(selectedTab: .constant(0), swipeDirection: .left)
    }
}
