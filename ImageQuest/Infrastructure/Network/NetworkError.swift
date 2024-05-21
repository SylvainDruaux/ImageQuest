//
//  NetworkError.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 02/04/2024.
//

import Foundation

/// A Network error.
enum NetworkError: Error {
    /// Network error.
    case network(Error)
    /// Bad request.
    case badRequest(String?)
    /// Unauthorised.
    case unauthorised(String?)
    /// Forbidden.
    case forbidden(String?)
    /// Not found.
    case notFound(String?)
    /// Too many requests.
    case tooManyRequests(String?)
    /// Internal server error.
    case internalServerError(String?)
    /// Not implemented.
    case notImplemented(String?)
    /// Bad gateway.
    case badGateway(String?)
    /// Service unavailable.
    case serviceUnavailable(String?)
    /// Gateway timeout.
    case gatewayTimeout(String?)
    /// Data decode error.
    case decode(Error)
    /// Unknown error.
    case unknown
}
