//
//  SearchEndpoint.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

enum SearchEndpoint {
    private static let baseURL = Constants.unsplashBaseURL
    private static let clientId = Constants.clientId
    
    static func photos(query: String) -> Endpoint {
        var parameters = [String: Any]()
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.query] = query
        parameters[QueryItemName.orderBy] = "latest"
        
        return Endpoint(
            baseURL: baseURL,
            path: "search/photos",
            method: .get,
            queryParameters: parameters
        )
    }
}
