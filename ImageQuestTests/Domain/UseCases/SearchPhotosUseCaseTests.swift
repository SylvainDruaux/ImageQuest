//
//  SearchPhotosUseCaseTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 04/04/2024.
//

@testable import ImageQuest
import XCTest

class SearchPhotosUseCaseTests: XCTestCase {
    private var photoRepositoryMock: PhotoRepositoryProtocolMock!
    private var sut: SearchPhotosUseCase!
    
    override func setUp() {
        super.setUp()
        photoRepositoryMock = PhotoRepositoryProtocolMock()
        sut = SearchPhotosUseCase(photoRepository: photoRepositoryMock)
    }
    
    func testExecuteCallsSearchPhotosInRepository() async throws {
        // GIVEN
        let expectedQuery = "query"
        let expectedPhotosPage: PhotosPage = .stub
        photoRepositoryMock.searchPhotosQueryPagePerPageOrderByReturnValue = expectedPhotosPage
        
        // WHEN
        let photosPageResult = try await sut.execute(query: expectedQuery)
        
        // THEN
        let arguments = photoRepositoryMock.searchPhotosQueryPagePerPageOrderByReceivedArguments
        XCTAssert(photoRepositoryMock.searchPhotosQueryPagePerPageOrderByCalled)
        XCTAssertEqual(arguments?.query, expectedQuery)
        XCTAssertEqual(photosPageResult, expectedPhotosPage)
    }
}
