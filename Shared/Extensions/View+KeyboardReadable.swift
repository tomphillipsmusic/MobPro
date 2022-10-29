//
//  KeyboardReadable.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/27/22.
//

import Combine
import SwiftUI

// https://stackoverflow.com/questions/65784294/how-to-detect-if-keyboard-is-present-in-swiftui
//extension View {
//    var keyboardPublisher: AnyPublisher<Bool, Never> {
//        Publishers
//            .Merge(
//                NotificationCenter
//                    .default
//                    .publisher(for: UIResponder.keyboardWillShowNotification)
//                    .map { _ in true },
//                NotificationCenter
//                    .default
//                    .publisher(for: UIResponder.keyboardWillHideNotification)
//                    .map { _ in false}
//            )
//            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
//            .eraseToAnyPublisher()
//    }
//}

/// Publisher to read keyboard changes.
protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}
