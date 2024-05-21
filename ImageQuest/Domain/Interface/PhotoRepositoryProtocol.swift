//
//  PhotoRepositoryProtocol.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import Foundation

// sourcery: AutoMockable
protocol PhotoRepositoryProtocol {
    func searchPhotos(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> PhotosPage
    func listPhotos(page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> [Photo]
    func getPhotoDetails(id: Photo.ID) async throws -> Photo
}
