//
//  LatestPhotosUseCaseTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 04/04/2024.
//

@testable import ImageQuest
import XCTest

class LatestPhotosUseCaseTests: XCTestCase {
    private var photoRepositoryMock: PhotoRepositoryProtocolMock!
    private var sut: LatestPhotosUseCase!
    
    override func setUp() {
        super.setUp()
        photoRepositoryMock = PhotoRepositoryProtocolMock()
        sut = LatestPhotosUseCase(photoRepository: photoRepositoryMock)
    }
    
    func testExecuteCallsListPhotosInRepository() async throws {
        // GIVEN
        let expectedPhotos: [Photo] = [.firstPhoto, .secondPhoto, .thirdPhoto]
        photoRepositoryMock.listPhotosPagePerPageOrderByReturnValue = expectedPhotos
        
        // WHEN
        let photosResult = try await sut.execute()
        
        // THEN
        XCTAssert(photoRepositoryMock.listPhotosPagePerPageOrderByCalled)
        XCTAssertEqual(photosResult, expectedPhotos)
    }
}
