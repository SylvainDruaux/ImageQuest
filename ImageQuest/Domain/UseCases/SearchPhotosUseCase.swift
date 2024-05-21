//
//  SearchPhotosUseCase.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

// sourcery: AutoMockable
protocol SearchPhotosUseCaseProtocol {
    func execute(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> PhotosPage
}

final class SearchPhotosUseCase: SearchPhotosUseCaseProtocol {
    private let photoRepository: PhotoRepositoryProtocol
    
    init(photoRepository: PhotoRepositoryProtocol = PhotoRepository()) {
        self.photoRepository = photoRepository
    }
    
    func execute(query: String, page: Int? = nil, perPage: Int? = nil, orderBy: OrderBy? = nil) async throws -> PhotosPage {
        try await photoRepository.searchPhotos(query: query, page: page, perPage: perPage, orderBy: orderBy)
    }
}
