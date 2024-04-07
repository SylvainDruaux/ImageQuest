//
//  PhotoDetailViewModel.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import Foundation

@MainActor
final class PhotoDetailViewModel: ObservableObject {
    @Published private(set) var detailedPhoto: Photo?
    @Published private(set) var error: String?
    @Published var hasError = false
    @Published var isShowingPhotoInfoSheet = false
    
    private let detailedPhotoUseCase: DetailedPhotoUseCaseProtocol
    
    init(detailedPhotoUseCase: DetailedPhotoUseCaseProtocol = DetailedPhotoUseCase()) {
        self.detailedPhotoUseCase = detailedPhotoUseCase
    }
    
    func loadDetailedPhoto(_ photoID: Photo.ID) async {
        do {
            detailedPhoto = try await detailedPhotoUseCase.execute(id: photoID)
        } catch {
            self.error = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
            hasError = true
        }
    }
}
