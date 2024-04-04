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

final class SearchPhotosUseCaseProtocolMock: SearchPhotosUseCaseProtocol {

    // MARK: - execute
    var executeQueryPagePerPageOrderByThrowableError: Error?
    var executeQueryPagePerPageOrderByCallsCount = 0
    var executeQueryPagePerPageOrderByCalled: Bool {
        return executeQueryPagePerPageOrderByCallsCount > 0
    }
    var executeQueryPagePerPageOrderByReceivedArguments: (query: String, page: Int?, perPage: Int?, orderBy: OrderBy?)?
    var executeQueryPagePerPageOrderByReceivedInvocations: [(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?)] = []
    var executeQueryPagePerPageOrderByReturnValue: PhotosPage!
    var executeQueryPagePerPageOrderByClosure: ((String, Int?, Int?, OrderBy?) async throws -> PhotosPage)?

    func execute(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?) async throws -> PhotosPage {
        if let error = executeQueryPagePerPageOrderByThrowableError {
            throw error
        }
        executeQueryPagePerPageOrderByCallsCount += 1
            executeQueryPagePerPageOrderByReceivedArguments = (query: query, page: page, perPage: perPage, orderBy: orderBy)
            executeQueryPagePerPageOrderByReceivedInvocations.append((query: query, page: page, perPage: perPage, orderBy: orderBy))
        if let executeQueryPagePerPageOrderByClosure = executeQueryPagePerPageOrderByClosure {
            return try await executeQueryPagePerPageOrderByClosure(query, page, perPage, orderBy)
        } else {
            return executeQueryPagePerPageOrderByReturnValue
        }
    }
}

// swiftlint:enable all
