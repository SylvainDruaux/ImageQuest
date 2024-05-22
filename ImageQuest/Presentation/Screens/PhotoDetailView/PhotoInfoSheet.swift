//
//  PhotoInfoSheet.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI
import MapKit

struct PhotoInfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    let photo: Photo
    let cameraPosition: MapCameraPosition?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Info")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Button("Close") { dismiss() }
            }
            .padding(.top)
            .padding(.bottom, 48)
            
            if let description = photo.description {
                Text(description)
                    .lineLimit(4)
                    .minimumScaleFactor(0.75)
                    .padding(.bottom)
            }
            
            if let cameraPosition,
               let position = photo.location?.position,
               let latitude = position.latitude,
               let longitude = position.longitude {
                Map(initialPosition: cameraPosition) {
                    Marker("", coordinate: CLLocationCoordinate2D(
                        latitude: latitude,
                        longitude: longitude
                    ))
                }
                .frame(height: 150)
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
        .padding(.horizontal)
    }
}

#Preview {
    let cameraPosition = MapCameraPosition.region(.init(
        center: CLLocationCoordinate2D(
            latitude: Photo.firstPhoto.location?.position?.latitude ?? 0.0,
            longitude: Photo.firstPhoto.location?.position?.longitude ?? 0.0
        ),
        latitudinalMeters: 1100, longitudinalMeters: 1100
    ))
    
    return PhotoInfoSheet(photo: .firstPhoto, cameraPosition: cameraPosition)
        .preferredColorScheme(.dark)
}
