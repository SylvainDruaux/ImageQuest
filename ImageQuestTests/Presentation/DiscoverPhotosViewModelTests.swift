//
//  DiscoverPhotosViewModelTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 06/04/2024.
//

@testable import ImageQuest
import XCTest

class DiscoverPhotosViewModelTests: XCTestCase {
    private var latestPhotosUseCaseMock: LatestPhotosUseCaseProtocolMock!
    private var searchPhotoUseCaseMock: SearchPhotosUseCaseProtocolMock!
    
    private var sut: DiscoverPhotosViewModel!
    
    private let expectedQuery = "query"
    private let expectedError = NetworkError.unknown
    private let expectedLatestPhotos: [Photo] = [.firstPhoto, .secondPhoto, .thirdPhoto]
    private let expectedPhotosPage: PhotosPage = .stub
    
    @MainActor override func setUp() {
        super.setUp()
        latestPhotosUseCaseMock = LatestPhotosUseCaseProtocolMock()
        searchPhotoUseCaseMock = SearchPhotosUseCaseProtocolMock()
        
        sut = DiscoverPhotosViewModel(
            latestPhotosUseCase: latestPhotosUseCaseMock,
            searchPhotoUseCase: searchPhotoUseCaseMock
        )
    }
    
    @MainActor func testClearPhotos() async {
        // GIVEN
        searchPhotoUseCaseMock.executeQueryPagePerPageOrderByReturnValue = expectedPhotosPage
        
        // WHEN
        await sut.loadPhotosNamed(query: expectedQuery)
        var photos = sut.photos
        
        // THEN
        XCTAssertFalse(photos.isEmpty)
        
        // WHEN
        sut.clearPhotos()
        photos = sut.photos
        
        // THEN
        XCTAssertTrue(photos.isEmpty)
    }
    
    @MainActor func testLoadLatestPhotosSuccess() async {
        // GIVEN
        latestPhotosUseCaseMock.executePagePerPageReturnValue = expectedLatestPhotos
        
        // WHEN
        await sut.loadLatestPhotos()
        
        // THEN
        XCTAssert(latestPhotosUseCaseMock.executePagePerPageCalled)
        XCTAssertEqual(sut.latestPhotos, expectedLatestPhotos)
    }
    
    @MainActor func testLoadLatestPhotosFailure() async {
        // GIVEN
        latestPhotosUseCaseMock.executePagePerPageThrowableError = expectedError
        
        // WHEN
        await sut.loadLatestPhotos()
        
        // THEN
        XCTAssertEqual(sut.error?.localizedDescription, expectedError.localizedDescription)
    }
    
    @MainActor func testLoadPhotosNamedSuccess() async {
        // GIVEN
        searchPhotoUseCaseMock.executeQueryPagePerPageOrderByReturnValue = expectedPhotosPage
        let expectedPhotos = expectedPhotosPage.photos
        
        // WHEN
        await sut.loadPhotosNamed(query: expectedQuery)
        
        // THEN
        let arguments = searchPhotoUseCaseMock.executeQueryPagePerPageOrderByReceivedArguments
        XCTAssert(searchPhotoUseCaseMock.executeQueryPagePerPageOrderByCalled)
        XCTAssertEqual(arguments?.query, expectedQuery)
        XCTAssertEqual(arguments?.page, 1)
        XCTAssertEqual(arguments?.perPage, 20)
        XCTAssertEqual(arguments?.orderBy, nil)
        XCTAssertEqual(sut.photos, expectedPhotos)
    }
    
    @MainActor func testLoadPhotosNamedFailure() async {
        // GIVEN
        searchPhotoUseCaseMock.executeQueryPagePerPageOrderByThrowableError = expectedError
        
        // WHEN
        await sut.loadPhotosNamed(query: expectedQuery)
        
        // THEN
        XCTAssertEqual(sut.error?.localizedDescription, expectedError.localizedDescription)
    }
}
