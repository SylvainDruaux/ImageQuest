//
//  NetworkAlert.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 20/05/2024.
//

import SwiftUI

extension NetworkError: AppAlert {
    var title: String {
        switch self {
        case .network(let error):
            if error.isOtherConnectionError {
                return "Poor connection"
            }
            return "Network error"
            
        case .badRequest:
            return "Bad request"
            
        case .unauthorised, .forbidden:
            return "Unauthorized access"
            
        case .notFound:
            return "Not found"
            
        case .tooManyRequests:
            return "Too many requests"
            
        case .internalServerError, .notImplemented, .badGateway, .serviceUnavailable, .gatewayTimeout:
            return "Server error"
            
        case .decode:
            return "Data error"
            
        case .unknown:
            return "Unknown error"
        }
    }
    
    var message: String? {
        switch self {
        case .network(let error):
            if error.isOtherConnectionError {
                return "Check your network or switch to a faster connection, then try again."
            }
            return "Something went wrong on our end. Please try again later."
            
        case .badRequest:
            return "The request was invalid, usually due to a missing required parameter."
            
        case .unauthorised, .forbidden:
            return "Missing permissions to perform request."
            
        case .notFound:
            return "The requested resource doesn’t exist."
            
        case .tooManyRequests:
            return "Too many requests. Please try again later."
            
        case .internalServerError, .notImplemented, .badGateway, .serviceUnavailable, .gatewayTimeout:
            return "Something went wrong on our end. Please try again later."
            
        case .decode:
            return "Could not retrieve data. Please try again later."
            
        case .unknown:
            return "Unknown error."
        }
    }
    
    func getButtonsForAlert(action: (() -> Void)?) -> AnyView {
        AnyView(getButtons(action: action))
    }
    
    @ViewBuilder private func getButtons(action: (() -> Void)?) -> some View {
        switch self {
        case .network:
            Button("Try again") {
                action?()
            }
        default:
            Button("OK", role: .cancel) {}
        }
    }
}
