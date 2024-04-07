//
//  DiscoverPhotosViewModel.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 05/04/2024.
//

import Foundation

@MainActor
final class DiscoverPhotosViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var latestPhotos: [Photo] = []
    @Published private(set) var photos: [Photo] = []
    @Published private(set) var latestPhotosLayout = ColumnLayout<Photo>(properties: FixedColumnLayoutProperties.twoColumns)
    @Published private(set) var photosLayout = ColumnLayout<Photo>(properties: FixedColumnLayoutProperties.twoColumns)
    @Published private(set) var error: String?
    @Published var hasError = false
    
    private var photosTotalPages: Int = 1
    private var photosPageNumber: Int = 1
    
    private let latestPhotosUseCase: LatestPhotosUseCaseProtocol
    private let searchPhotoUseCase: SearchPhotosUseCaseProtocol
    
    init(
        latestPhotosUseCase: LatestPhotosUseCaseProtocol = LatestPhotosUseCase(),
        searchPhotoUseCase: SearchPhotosUseCaseProtocol = SearchPhotosUseCase()
    ) {
        self.latestPhotosUseCase = latestPhotosUseCase
        self.searchPhotoUseCase = searchPhotoUseCase
    }
    
    func clearPhotos() {
        photos.removeAll()
        photosPageNumber = 1
    }
    
    func loadLatestPhotos() async {
        do {
            latestPhotos = try await latestPhotosUseCase.execute(page: 1, perPage: 30)
        } catch {
            self.error = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
            hasError = true
        }
    }
    
    func loadPhotosNamed(query: String) async {
        guard photosPageNumber <= min(photosTotalPages, 10) else { return } // Limited at 10 pages maximum to limit requests
        
        do {
            let photosPage = try await searchPhotoUseCase.execute(query: query, page: photosPageNumber, perPage: 20, orderBy: nil)
            photosTotalPages = photosPage.totalPages
            photos += photosPage.photos
            photosPageNumber += 1
        } catch {
            self.error = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
            hasError = true
        }
    }
}
