//
//  ContentView.swift
//  Shared
//
//  Created by Tom Phillips on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var session = MobSession()
    
    var body: some View {
        Text("Round \(session.currentRotationNumber) / \(session.numberOfRotationsBetweenBreaks)")
            .font(.title2)
            .bold()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
