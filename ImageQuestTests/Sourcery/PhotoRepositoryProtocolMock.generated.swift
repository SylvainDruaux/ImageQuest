// Generated using Sourcery 2.2.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import ImageQuest
import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

final class PhotoRepositoryProtocolMock: PhotoRepositoryProtocol {

    // MARK: - searchPhotos
    var searchPhotosQueryPagePerPageOrderByThrowableError: Error?
    var searchPhotosQueryPagePerPageOrderByCallsCount = 0
    var searchPhotosQueryPagePerPageOrderByCalled: Bool {
        return searchPhotosQueryPagePerPageOrderByCallsCount > 0
    }
    var searchPhotosQueryPagePerPageOrderByReceivedArguments: (query: String, page: Int?, perPage: Int?, orderBy: OrderBy?)?
    var searchPhotosQueryPagePerPageOrderByReceivedInvocations: [(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?)] = []
    var searchPhotosQueryPagePerPageOrderByReturnValue: PhotosPage!
    var searchPhotosQueryPagePerPageOrderByClosure: ((String, Int?, Int?, OrderBy?) async throws -> PhotosPage)?

    func searchPhotos(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> PhotosPage {
        if let error = searchPhotosQueryPagePerPageOrderByThrowableError {
            throw error
        }
        searchPhotosQueryPagePerPageOrderByCallsCount += 1
            searchPhotosQueryPagePerPageOrderByReceivedArguments = (query: query, page: page, perPage: perPage, orderBy: orderBy)
            searchPhotosQueryPagePerPageOrderByReceivedInvocations.append((query: query, page: page, perPage: perPage, orderBy: orderBy))
        if let searchPhotosQueryPagePerPageOrderByClosure = searchPhotosQueryPagePerPageOrderByClosure {
            return try await searchPhotosQueryPagePerPageOrderByClosure(query, page, perPage, orderBy)
        } else {
            return searchPhotosQueryPagePerPageOrderByReturnValue
        }
    }

    // MARK: - listPhotos
    var listPhotosPagePerPageOrderByThrowableError: Error?
    var listPhotosPagePerPageOrderByCallsCount = 0
    var listPhotosPagePerPageOrderByCalled: Bool {
        return listPhotosPagePerPageOrderByCallsCount > 0
    }
    var listPhotosPagePerPageOrderByReceivedArguments: (page: Int?, perPage: Int?, orderBy: OrderBy?)?
    var listPhotosPagePerPageOrderByReceivedInvocations: [(page: Int?, perPage: Int?, orderBy: OrderBy?)] = []
    var listPhotosPagePerPageOrderByReturnValue: [Photo]!
    var listPhotosPagePerPageOrderByClosure: ((Int?, Int?, OrderBy?) async throws -> [Photo])?

    func listPhotos(page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> [Photo] {
        if let error = listPhotosPagePerPageOrderByThrowableError {
            throw error
        }
        listPhotosPagePerPageOrderByCallsCount += 1
            listPhotosPagePerPageOrderByReceivedArguments = (page: page, perPage: perPage, orderBy: orderBy)
            listPhotosPagePerPageOrderByReceivedInvocations.append((page: page, perPage: perPage, orderBy: orderBy))
        if let listPhotosPagePerPageOrderByClosure = listPhotosPagePerPageOrderByClosure {
            return try await listPhotosPagePerPageOrderByClosure(page, perPage, orderBy)
        } else {
            return listPhotosPagePerPageOrderByReturnValue
        }
    }

    // MARK: - getPhotoDetails
    var getPhotoDetailsIdThrowableError: Error?
    var getPhotoDetailsIdCallsCount = 0
    var getPhotoDetailsIdCalled: Bool {
        return getPhotoDetailsIdCallsCount > 0
    }
    var getPhotoDetailsIdReceivedId: Photo.ID?
    var getPhotoDetailsIdReceivedInvocations: [Photo.ID] = []
    var getPhotoDetailsIdReturnValue: Photo!
    var getPhotoDetailsIdClosure: ((Photo.ID) async throws -> Photo)?

    func getPhotoDetails(id: Photo.ID) async throws -> Photo {
        if let error = getPhotoDetailsIdThrowableError {
            throw error
        }
        getPhotoDetailsIdCallsCount += 1
        getPhotoDetailsIdReceivedId = id
        getPhotoDetailsIdReceivedInvocations.append(id)
        if let getPhotoDetailsIdClosure = getPhotoDetailsIdClosure {
            return try await getPhotoDetailsIdClosure(id)
        } else {
            return getPhotoDetailsIdReturnValue
        }
    }
}

// swiftlint:enable all
