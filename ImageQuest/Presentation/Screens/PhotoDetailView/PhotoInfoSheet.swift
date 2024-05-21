//
//  PhotoInfoSheet.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import SwiftUI
import MapKit

struct PhotoInfoSheet: View {
    let photo: Photo
    let cameraPosition: MapCameraPosition?
    
    var body: some View {
        VStack(alignment: .leading) {
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
        .navigationTitle("Info")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 32)
        .padding(.horizontal)
    }
}

#if DEBUG
struct PhotoInfoSheetContainer: View {
    let cameraPosition = MapCameraPosition.region(.init(
        center: CLLocationCoordinate2D(
            latitude: Photo.firstPhoto.location?.position?.latitude ?? 0.0,
            longitude: Photo.firstPhoto.location?.position?.longitude ?? 0.0
        ),
        latitudinalMeters: 1100, longitudinalMeters: 1100
    ))
    
    var body: some View {
        PhotoInfoSheet(photo: .firstPhoto, cameraPosition: cameraPosition)
    }
}
#endif

#Preview {
    NavigationStack {
        PhotoInfoSheetContainer()
    }
    .preferredColorScheme(.dark)
}
