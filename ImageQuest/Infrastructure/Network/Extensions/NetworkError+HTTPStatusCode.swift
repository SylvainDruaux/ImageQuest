//
//  NetworkError+HTTPStatusCode.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 02/04/2024.
//

import Foundation

extension NetworkError {
    init(statusCode: Int, message: String?) {
        switch statusCode {
        case 400:
            self = .badRequest(message)
            
        case 401:
            self = .unauthorised(message)
            
        case 403:
            self = .forbidden(message)
            
        case 404:
            self = .notFound(message)
            
        case 429:
            self = .tooManyRequests(message)
            
        case 500:
            self = .internalServerError(message)
            
        case 501:
            self = .notImplemented(message)
            
        case 502:
            self = .badGateway(message)
            
        case 503:
            self = .serviceUnavailable(message)
            
        case 504:
            self = .gatewayTimeout(message)
            
        default:
            self = .unknown
        }
    }
}
