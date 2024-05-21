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
    
    static func photos(query: String, page: Int?, perPage: Int?, orderBy: OrderBy?) -> Endpoint {
        var parameters = [String: Any]()
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.query] = query
        
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
        
        /// How to sort the photos. (Optional; default: relevant). Valid values are latest and relevant.
        if let orderBy {
            parameters[QueryItemName.orderBy] = orderBy.rawValue
        }
        
        return Endpoint(
            baseURL: baseURL,
            path: "search/photos",
            method: .get,
            queryParameters: parameters
        )
    }
}
