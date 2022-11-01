//
//  TeamMember.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 10/30/22.
//

import Foundation

struct TeamMember: Identifiable, Equatable, Codable {
    var id = UUID()
    var name: String
    var role: Role
    
    var description: String {
        "\(name). \(role). "
    }
}
