//
//  PhotoInfoSheet.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI

struct PhotoInfoSheet: View {
    let photo: Photo
    
    var body: some View {
        VStack(alignment: .leading) {
            if let description = photo.description {
                Text(description)
                    .padding(.bottom)
            }
            
            if let locationName = photo.location?.name {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                    Text(locationName)
                    Spacer()
                }
                .font(.caption)
                .padding(.bottom)
            }
            
            Divider().overlay(.secondary)
                .padding(.bottom)
            
            CameraInfoSection(photo: photo)
            
            Spacer()
        }
        .navigationTitle("Info")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 32)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        PhotoInfoSheet(photo: .firstPhoto)
    }
    .preferredColorScheme(.dark)
}
