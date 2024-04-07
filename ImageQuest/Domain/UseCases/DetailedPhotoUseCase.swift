//
//  DetailedPhotoUseCase.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

// sourcery: AutoMockable
protocol DetailedPhotoUseCaseProtocol {
    func execute(id: Photo.ID) async throws -> Photo
}

final class DetailedPhotoUseCase: DetailedPhotoUseCaseProtocol {
    private let photoRepository: PhotoRepositoryProtocol
    
    init(photoRepository: PhotoRepositoryProtocol = PhotoRepository()) {
        self.photoRepository = photoRepository
    }
    
    func execute(id: Photo.ID) async throws -> Photo {
        try await photoRepository.getPhotoDetails(id: id)
    }
}
