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

final class DetailedPhotoUseCaseProtocolMock: DetailedPhotoUseCaseProtocol {

    // MARK: - execute
    var executeIdThrowableError: Error?
    var executeIdCallsCount = 0
    var executeIdCalled: Bool {
        return executeIdCallsCount > 0
    }
    var executeIdReceivedId: String?
    var executeIdReceivedInvocations: [String] = []
    var executeIdReturnValue: Photo!
    var executeIdClosure: ((String) async throws -> Photo)?

    func execute(id: String) async throws -> Photo {
        if let error = executeIdThrowableError {
            throw error
        }
        executeIdCallsCount += 1
        executeIdReceivedId = id
        executeIdReceivedInvocations.append(id)
        if let executeIdClosure = executeIdClosure {
            return try await executeIdClosure(id)
        } else {
            return executeIdReturnValue
        }
    }
}

// swiftlint:enable all
