//
//  ConfigurationSwipeButton+SwipeDirection.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 8/14/22.
//

import SwiftUI

extension ConfigurationSwipeButton {
    enum SwipeDirection {
        case right, left
    }
    
    func switchConfiguration() {
        switch swipeDirection {
        case .right:
            selectedTab += 1
        case .left:
            selectedTab -= 1
        }
    }
    
    var imageName: String {
        switch swipeDirection {
        case .right:
            return "chevron.right"
        case .left:
            return "chevron.left"
        }
    }
    
    var color: Color {
        switch swipeDirection {
        case .left:
            switch selectedTab {
            case 1:
                return Color(vm.mobTimer.rotationLength.color)
            case 2:
                return Color(vm.session.numberOfRotationsBetweenBreaks.color)
            default:
                return .mobGray
            }
        case .right:
            switch selectedTab {
            case 0:
                return Color(vm.session.numberOfRotationsBetweenBreaks.color)
            case 1:
                return Color(vm.session.breakLengthInSeconds.color)
            default:
                return .mobGray
            }
        }
    }
    
    var isDisabled: Bool {
        switch swipeDirection {
        case .right:
            return selectedTab > 1
        case .left:
            return selectedTab < 1
        }
    }
}
