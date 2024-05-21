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

final class APIClientProtocolMock: APIClientProtocol {
    typealias Response = Decodable

    // MARK: - request<Response: Decodable>
    var requestEndpointThrowableError: Error?
    var requestEndpointCallsCount = 0
    var requestEndpointCalled: Bool {
        return requestEndpointCallsCount > 0
    }
    var requestEndpointReceivedEndpoint: Endpoint?
    var requestEndpointReceivedInvocations: [Endpoint] = []
    var requestEndpointReturnValue: Response!
    var requestEndpointClosure: ((Endpoint) async throws -> Response)?

    func request<Response: Decodable>(endpoint: Endpoint) async throws -> Response {
        if let error = requestEndpointThrowableError {
            throw error
        }
        requestEndpointCallsCount += 1
        requestEndpointReceivedEndpoint = endpoint
        requestEndpointReceivedInvocations.append(endpoint)
        if let requestEndpointClosure = requestEndpointClosure {
            return try await requestEndpointClosure(endpoint) as! Response
        } else {
            return requestEndpointReturnValue as! Response
        }
    }

    // MARK: - request
    var requestEndpointReturnDataValue: Data!
    var requestEndpointDataClosure: ((Endpoint) async throws -> Data)?

    func request(endpoint: Endpoint) async throws -> Data {
        if let error = requestEndpointThrowableError {
            throw error
        }
        requestEndpointCallsCount += 1
        requestEndpointReceivedEndpoint = endpoint
        requestEndpointReceivedInvocations.append(endpoint)
        if let requestEndpointDataClosure = requestEndpointDataClosure {
            return try await requestEndpointDataClosure(endpoint)
        } else {
            return requestEndpointReturnDataValue
        }
    }
}

// swiftlint:enable all
