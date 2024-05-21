//
//  LatestPhotosUseCase.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

// sourcery: AutoMockable
protocol LatestPhotosUseCaseProtocol {
    func execute(page: Int?, perPage: Int?) async throws -> [Photo]
}

final class LatestPhotosUseCase: LatestPhotosUseCaseProtocol {
    private let photoRepository: PhotoRepositoryProtocol
    
    init(photoRepository: PhotoRepositoryProtocol = PhotoRepository()) {
        self.photoRepository = photoRepository
    }
    
    func execute(page: Int? = nil, perPage: Int? = nil) async throws -> [Photo] {
        try await photoRepository.listPhotos(page: page, perPage: perPage, orderBy: .latest)
    }
}
