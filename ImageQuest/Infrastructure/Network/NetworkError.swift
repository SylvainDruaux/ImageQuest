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

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network(let error):
            if error.isOtherConnectionError {
                return "Check your network or switch to a faster connection, then try again."
            }
            return error.localizedDescription
            
        case .badRequest:
            return "The request was unacceptable, often due to missing a required parameter"
            
        case .unauthorised:
            return "Invalid Access Token"
                        
        case .forbidden:
            return "Missing permissions to perform request"
            
        case .notFound:
            return "The requested resource doesn’t exist"
            
        case .tooManyRequests:
            return "Too many requests"
            
        case .internalServerError, .notImplemented, .badGateway, .serviceUnavailable, .gatewayTimeout:
            return "Something went wrong on our end"
            
        case .decode(let error):
            return error.localizedDescription
            
        case .unknown:
            return "Unknown error"
        }
    }
}
