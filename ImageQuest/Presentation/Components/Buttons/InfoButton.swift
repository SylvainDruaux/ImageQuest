//
//  InfoButton.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI

struct InfoButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "info.circle")
                .font(.system(size: 20))
                .frame(width: 44, height: 44)
        }
    }
}

#Preview {
    InfoButton {}
        .preferredColorScheme(.dark)
}
