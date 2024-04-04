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

final class EndpointProtocolMock: EndpointProtocol {
    var baseURL: String {
        get { return underlyingBaseURL }
        set(value) { underlyingBaseURL = value }
    }
    var underlyingBaseURL: String!
    var path: String {
        get { return underlyingPath }
        set(value) { underlyingPath = value }
    }
    var underlyingPath: String!
    var method: HTTPMethod {
        get { return underlyingMethod }
        set(value) { underlyingMethod = value }
    }
    var underlyingMethod: HTTPMethod!
    var queryParameters: [String: Any] = [:]
    var cachePolicy: URLRequest.CachePolicy {
        get { return underlyingCachePolicy }
        set(value) { underlyingCachePolicy = value }
    }
    var underlyingCachePolicy: URLRequest.CachePolicy!

    // MARK: - urlRequest
    var urlRequestThrowableError: Error?
    var urlRequestCallsCount = 0
    var urlRequestCalled: Bool {
        return urlRequestCallsCount > 0
    }
    var urlRequestReturnValue: URLRequest!
    var urlRequestClosure: (() async throws -> URLRequest)?

    func urlRequest() async throws -> URLRequest {
        if let error = urlRequestThrowableError {
            throw error
        }
        urlRequestCallsCount += 1
        if let urlRequestClosure = urlRequestClosure {
            return try await urlRequestClosure()
        } else {
            return urlRequestReturnValue
        }
    }
}

// swiftlint:enable all
