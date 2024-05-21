//
//  PhotoOverlay.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 07/04/2024.
//

import SwiftUI

struct PhotoOverlay: ViewModifier {
    let name: String
    
    func body(content: Content) -> some View {
        content
            .overlay(Color.black.opacity(0.2))
            .overlay(alignment: .bottomLeading) {
                Text(name)
                    .font(.footnote).bold()
                    .padding([.bottom, .leading], 6)
            }
    }
}

extension View {
    func photoOverlay(name: String) -> some View {
        modifier(PhotoOverlay(name: name))
    }
}
