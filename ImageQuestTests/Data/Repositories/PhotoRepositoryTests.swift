//
//  PhotoRepositoryTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 04/04/2024.
//

@testable import ImageQuest
import XCTest

class PhotoRepositoryTests: XCTestCase {
    private var apiClientMock: APIClientProtocolMock!
    private var sut: PhotoRepository!
    private let expectedPhotoPageableListDTO: PhotoPageableListDTO = .stub
    private let expectedPhotoResponseDTOArray: [PhotoResponseDTO] = [.firstPhoto, .secondPhoto, .thirdPhoto]
    
    override func setUp() {
        super.setUp()
        apiClientMock = APIClientProtocolMock()
        sut = PhotoRepository(apiClient: apiClientMock)
    }
    
    func testSearchPhotosCallsApiClient() async throws {
        // GIVEN
        let expectedQuery = "query"
        apiClientMock.requestEndpointReturnValue = expectedPhotoPageableListDTO
        let expectedPhotosPage = expectedPhotoPageableListDTO.toDomain()
        
        // WHEN
        let photosPageResult = try await sut.searchPhotos(query: expectedQuery, page: nil, perPage: nil, orderBy: nil)
        
        // THEN
        XCTAssert(apiClientMock.requestEndpointCalled)
        XCTAssertEqual(photosPageResult, expectedPhotosPage)
    }
    
    func testListPhotosCallsApiClient() async throws {
        // GIVEN
        apiClientMock.requestEndpointReturnValue = expectedPhotoResponseDTOArray
        let expectedPhotos = expectedPhotoResponseDTOArray.map { $0.toDomain() }
        
        // WHEN
        let photosResult = try await sut.listPhotos(page: 2, perPage: nil, orderBy: nil)
        
        // THEN
        XCTAssert(apiClientMock.requestEndpointCalled)
        XCTAssertEqual(photosResult, expectedPhotos)
    }
    
    func testGetPhotoDetailsCallsApiClient() async throws {
        // GIVEN
        let expectedPhotoResponseDTO: PhotoResponseDTO = .firstPhoto
        let expectedPhotoId = expectedPhotoResponseDTO.id
        apiClientMock.requestEndpointReturnValue = expectedPhotoResponseDTO
        
        // WHEN
        let photoResult = try await sut.getPhotoDetails(id: expectedPhotoId)
        
        // THEN
        XCTAssert(apiClientMock.requestEndpointCalled)
        XCTAssertEqual(photoResult, expectedPhotoResponseDTO.toDomain())
    }
}
