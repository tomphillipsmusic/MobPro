//
//  EditMode+Extension.swift
//  MobPro
//
//  Created by Tom Phillips on 10/30/22.
//

import SwiftUI

extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}
