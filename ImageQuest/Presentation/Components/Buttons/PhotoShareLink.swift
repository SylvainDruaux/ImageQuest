//
//  PhotoShareLink.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI

struct PhotoShareLink: View {
    let photo: Photo
    
    var body: some View {
        if let html = photo.links.html {
            ShareLink(item: html) {
                Image(systemName: "square.and.arrow.up")
                    .font(.footnote).bold()
                    .frame(width: 44, height: 44)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    PhotoShareLink(photo: .firstPhoto)
        .preferredColorScheme(.dark)
}
