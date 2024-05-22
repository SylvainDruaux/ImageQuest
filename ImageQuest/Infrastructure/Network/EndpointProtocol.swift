//
//  EndpointProtocol.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// sourcery: AutoMockable
protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: Any] { get }
    var cachePolicy: URLRequest.CachePolicy { get set }
    
    func urlRequest() async throws -> URLRequest
}

extension EndpointProtocol {
    private func url() -> URL {
        let baseUrl = baseURL.hasSuffix("/") ? baseURL : baseURL.appending("/")
        let endpoint = baseUrl.appending(path)
        
        guard var urlComponents = URLComponents(string: endpoint) else {
            fatalError("Invalid URL")
        }
        
        var urlQueryItems = [URLQueryItem]()
        for queryParameter in queryParameters {
            urlQueryItems.append(URLQueryItem(name: queryParameter.key, value: "\(queryParameter.value)"))
        }
        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
        
        guard let url = urlComponents.url else {
            fatalError("Invalid URL components")
        }
        
        return url
    }
    
    func urlRequest() async throws -> URLRequest {
        let url = url()
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
