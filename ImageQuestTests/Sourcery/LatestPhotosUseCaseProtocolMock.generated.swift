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

final class LatestPhotosUseCaseProtocolMock: LatestPhotosUseCaseProtocol {

    // MARK: - execute
    var executePagePerPageThrowableError: Error?
    var executePagePerPageCallsCount = 0
    var executePagePerPageCalled: Bool {
        return executePagePerPageCallsCount > 0
    }
    var executePagePerPageReceivedArguments: (page: Int?, perPage: Int?)?
    var executePagePerPageReceivedInvocations: [(page: Int?, perPage: Int?)] = []
    var executePagePerPageReturnValue: [Photo]!
    var executePagePerPageClosure: ((Int?, Int?) async throws -> [Photo])?

    func execute(page: Int?, perPage: Int?) async throws -> [Photo] {
        if let error = executePagePerPageThrowableError {
            throw error
        }
        executePagePerPageCallsCount += 1
            executePagePerPageReceivedArguments = (page: page, perPage: perPage)
            executePagePerPageReceivedInvocations.append((page: page, perPage: perPage))
        if let executePagePerPageClosure = executePagePerPageClosure {
            return try await executePagePerPageClosure(page, perPage)
        } else {
            return executePagePerPageReturnValue
        }
    }
}

// swiftlint:enable all
