//
//  PhotosEndpoint.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

enum PhotosEndpoint {
    private static let baseURL = Constants.unsplashBaseURL
    private static let clientId = Constants.clientId
    
    static func latest(perPage: Int) -> Endpoint {
        var parameters = [String: Any]()
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.perPage] = perPage
        
        return Endpoint(
            baseURL: baseURL,
            path: "photos",
            method: .get,
            queryParameters: parameters
        )
    }
}
