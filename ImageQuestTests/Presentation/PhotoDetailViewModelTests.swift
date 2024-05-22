//
//  PhotoDetailViewModelTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 06/04/2024.
//

@testable import ImageQuest
import XCTest

class PhotoDetailViewModelTests: XCTestCase {
    private var detailedPhotoUseCaseMock: DetailedPhotoUseCaseProtocolMock!
    
    private var sut: PhotoDetailViewModel!
    
    private let expectedError = NetworkError.unknown
    private let expectedDetailedPhoto: Photo = .firstPhoto
    
    @MainActor override func setUp() {
        super.setUp()
        detailedPhotoUseCaseMock = DetailedPhotoUseCaseProtocolMock()
        
        sut = PhotoDetailViewModel(detailedPhotoUseCase: detailedPhotoUseCaseMock)
    }
    
    @MainActor func testLoadDetailedPhotoSuccess() async {
        // GIVEN
        detailedPhotoUseCaseMock.executeIdReturnValue = expectedDetailedPhoto
        
        // WHEN
        await sut.loadDetailedPhoto(expectedDetailedPhoto.id)
        
        // THEN
        XCTAssert(detailedPhotoUseCaseMock.executeIdCalled)
        XCTAssertEqual(sut.detailedPhoto, expectedDetailedPhoto)
    }
    
    @MainActor func testLoadDetailedPhotoFailure() async {
        // GIVEN
        detailedPhotoUseCaseMock.executeIdThrowableError = expectedError
        
        // WHEN
        await sut.loadDetailedPhoto(expectedDetailedPhoto.id)
        
        // THEN
        XCTAssertEqual(sut.error?.localizedDescription, expectedError.localizedDescription)
    }
}
