//
//  PhotoRepository.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

final class PhotoRepository: PhotoRepositoryProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func searchPhotos(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> PhotosPage {
        let photoPageableListDTO: PhotoPageableListDTO = try await apiClient.request(
            endpoint: SearchEndpoint.photos(
                query: query, page: page, perPage: perPage, orderBy: orderBy)
        )
        return photoPageableListDTO.toDomain()
    }
    
    func listPhotos(page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> [Photo] {
        let photoListDTO: [PhotoResponseDTO] = try await apiClient.request(
            endpoint: PhotosEndpoint.list(page: page, perPage: perPage, orderBy: orderBy)
        )
        return photoListDTO.map { $0.toDomain() }
    }
    
    func getPhotoDetails(id: Photo.ID) async throws -> Photo {
        let endpoint = PhotosEndpoint.get(photoID: id)
        endpoint.cachePolicy = .returnCacheDataElseLoad
        let photoResponseDTO: PhotoResponseDTO = try await apiClient.request(endpoint: endpoint)
        return photoResponseDTO.toDomain()
    }
}
