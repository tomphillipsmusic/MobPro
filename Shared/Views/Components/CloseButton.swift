//
//  CloseButton.swift
//  MobPro
//
//  Created by Tom Phillips on 7/27/22.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "x.circle")
                    .font(.largeTitle)
                    .foregroundColor(.mobRed)
                    .padding()
            })
        }    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
