//
//  DetailedPhotoUseCaseTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 04/04/2024.
//

@testable import ImageQuest
import XCTest

class DetailedPhotoUseCaseTests: XCTestCase {
    private var photoRepositoryMock: PhotoRepositoryProtocolMock!
    private var sut: DetailedPhotoUseCase!
    
    override func setUp() {
        super.setUp()
        photoRepositoryMock = PhotoRepositoryProtocolMock()
        sut = DetailedPhotoUseCase(photoRepository: photoRepositoryMock)
    }
    
    func testExecuteCallsGetPhotoDetailsInRepository() async throws {
        // GIVEN
        let expectedPhoto: Photo = .firstPhoto
        photoRepositoryMock.getPhotoDetailsIdReturnValue = expectedPhoto
        
        // WHEN
        let photoResult = try await sut.execute(id: expectedPhoto.id)
        
        // THEN
        let receivedId = photoRepositoryMock.getPhotoDetailsIdReceivedId
        XCTAssert(photoRepositoryMock.getPhotoDetailsIdCalled)
        XCTAssertEqual(receivedId, expectedPhoto.id)
        XCTAssertEqual(photoResult, expectedPhoto)
    }
}
