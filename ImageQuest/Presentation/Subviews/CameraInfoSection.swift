//
//  CameraInfoSection.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI

struct CameraInfoSection: View {
    let photo: Photo
    
    var body: some View {
        Text("Camera").bold()
            .padding(.bottom)
        
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Make")
                    .opacity(0.8)
                Text(photo.exif?.make ?? "-")
                    .padding(.bottom)
                
                Text("Model")
                    .opacity(0.8)
                Text(photo.exif?.model ?? "-")
                    .padding(.bottom)
                
                Text("Sutter Speed (s)")
                    .opacity(0.8)
                Text(photo.exif?.shutterSpeed ?? "-")
                    .padding(.bottom)
                
                Text("Aperture (ƒ)")
                    .opacity(0.8)
                Text(photo.exif?.aperture ?? "-")
                    .padding(.bottom)
            }
            
            VStack(alignment: .leading) {
                Text("Focal Length (mm)")
                    .opacity(0.8)
                Text(photo.exif?.focalLength ?? "-")
                    .padding(.bottom)
                
                Text("ISO")
                    .opacity(0.8)
                Text(photo.exif?.iso ?? "-")
                    .padding(.bottom)
                
                Text("Dimensions")
                    .opacity(0.8)
                Text("\(photo.width) x \(photo.height)")
                    .padding(.bottom)
                
                Text("Published")
                    .opacity(0.8)
                Text(photo.published.formattedDate(style: .long))
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
        }
        .font(.footnote)
    }
}

#Preview {
    VStack(alignment: .leading) {
        CameraInfoSection(photo: .firstPhoto)
    }
    .preferredColorScheme(.dark)
}
