//
//  Endpoint.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

class Endpoint: EndpointProtocol {
    let baseURL: String
    let path: String
    let method: HTTPMethod
    let queryParameters: [String: Any]
    var cachePolicy: URLRequest.CachePolicy
    
    init(
        baseURL: String,
        path: String,
        method: HTTPMethod,
        queryParameters: [String: Any] = [:],
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.cachePolicy = cachePolicy
    }
}
