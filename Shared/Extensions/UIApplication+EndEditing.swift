//
//  UIApplication+EndEditing.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 7/27/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
