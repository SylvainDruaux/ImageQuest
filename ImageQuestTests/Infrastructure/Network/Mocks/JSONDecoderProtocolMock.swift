// Generated using Sourcery 2.2.2 — https://github.com/krzysztofzablocki/Sourcery
// EDITED - https://github.com/krzysztofzablocki/Sourcery/issues/811
// swiftlint:disable all

@testable import ImageQuest
import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

final class JSONDecoderProtocolMock: JSONDecoderProtocol {
    typealias T = Decodable

    // MARK: - decode<T: Decodable>
    var decodeFromThrowableError: Error?
    var decodeFromCallsCount = 0
    var decodeFromCalled: Bool {
        return decodeFromCallsCount > 0
    }
    var decodeFromReceivedArguments: (type: T.Type, data: Data)?
    var decodeFromReceivedInvocations: [(type: T.Type, data: Data)] = []
    var decodeFromReturnValue: T!
    var decodeFromClosure: ((T.Type, Data) throws -> T)?

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        if let error = decodeFromThrowableError {
            throw error
        }
        decodeFromCallsCount += 1
            decodeFromReceivedArguments = (type: type, data: data)
            decodeFromReceivedInvocations.append((type: type, data: data))
        if let decodeFromClosure = decodeFromClosure {
            return try decodeFromClosure(type, data) as! T
        } else {
            return decodeFromReturnValue as! T
        }
    }
}

// swiftlint:enable all
