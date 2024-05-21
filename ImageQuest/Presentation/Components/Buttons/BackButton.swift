//
//  BackButton.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "lessthan")
                .resizable()
                .frame(width: 10, height: 18)
                .frame(width: 44, height: 44)
        }
    }
}

#Preview {
    BackButton {}
        .preferredColorScheme(.dark)
}
