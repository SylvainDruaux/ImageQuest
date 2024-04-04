//
//  APIClientProtocol.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 02/04/2024.
//

import Foundation

protocol APIClientProtocol {
    func request<Response: Decodable>(endpoint: Endpoint) async throws -> Response
    func request(endpoint: Endpoint) async throws -> Data
}
