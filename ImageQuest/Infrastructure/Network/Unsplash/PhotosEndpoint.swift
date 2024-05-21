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
    
    static func list(page: Int?, perPage: Int?, orderBy: OrderBy?) -> Endpoint {
        var parameters = [String: Any]()
        parameters[QueryItemName.clientId] = clientId
        
        /// Page number to retrieve. (Optional; default: 1)
        if var page {
            page = max(page, 1)
            page = min(page, 1000)
            parameters[QueryItemName.page] = page
        }
        
        /// Number of items per page. (Optional; default: 10)
        if var perPage {
            perPage = max(perPage, 10)
            perPage = min(perPage, 50)
            parameters[QueryItemName.perPage] = perPage
        }
        
        /// How to sort the photos. Optional. (Valid values: latest, oldest, popular; default: latest)
        if let orderBy {
            parameters[QueryItemName.orderBy] = orderBy.rawValue
        }
        
        return Endpoint(
            baseURL: baseURL,
            path: "photos",
            method: .get,
            queryParameters: parameters
        )
    }
    
    static func get(photoID: String) -> Endpoint {
        var parameters = [String: Any]()
        parameters[QueryItemName.clientId] = clientId
        
        return Endpoint(
            baseURL: baseURL,
            path: "photos/\(photoID)",
            method: .get,
            queryParameters: parameters
        )
    }
}
