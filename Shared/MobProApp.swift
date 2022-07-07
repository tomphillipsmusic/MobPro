//
//  MobProApp.swift
//  Shared
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

@main
struct MobProApp: App {
    @StateObject var mobSessionManager = MobSessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mobSessionManager)
        }
    }
}
