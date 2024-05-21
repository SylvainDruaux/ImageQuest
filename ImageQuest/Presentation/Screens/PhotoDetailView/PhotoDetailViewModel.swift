//
//  PhotoDetailViewModel.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import Foundation
import _MapKit_SwiftUI

@MainActor
final class PhotoDetailViewModel: ObservableObject {
    @Published private(set) var detailedPhoto: Photo?
    @Published private(set) var cameraPosition: MapCameraPosition?
    @Published var error: NetworkError?
    @Published var isShowingPhotoInfoSheet = false
    
    private let detailedPhotoUseCase: DetailedPhotoUseCaseProtocol
    
    init(detailedPhotoUseCase: DetailedPhotoUseCaseProtocol = DetailedPhotoUseCase()) {
        self.detailedPhotoUseCase = detailedPhotoUseCase
    }
    
    func loadDetailedPhoto(_ photoID: Photo.ID) async {
        do {
            detailedPhoto = try await detailedPhotoUseCase.execute(id: photoID)
            
            if let position = detailedPhoto?.location?.position,
               let latitude = position.latitude, !latitude.isZero,
               let longitude = position.longitude, !longitude.isZero {
                cameraPosition = .region(.init(
                    center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                    latitudinalMeters: 1100, longitudinalMeters: 1100
                    
                ))
            }
        } catch {
            self.error = error as? NetworkError
        }
    }
}
