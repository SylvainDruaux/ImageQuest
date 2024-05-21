//
//  APIClient.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

final actor APIClient: APIClientProtocol {
    private let urlSession: URLSession
    private let decoder: JSONDecoderProtocol
    
    init(
        urlSession: URLSession = URLSession(configuration: .default),
        decoder: JSONDecoderProtocol = JSONDecoder.unsplashDecoder
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func request<Response: Decodable>(endpoint: Endpoint) async throws -> Response {
        let data = try await request(endpoint: endpoint)

        let decodedResponse: Response
        do {
            decodedResponse = try decoder.decode(Response.self, from: data)
        } catch {
            throw NetworkError.decode(error)
        }

        return decodedResponse
    }
    
    func request(endpoint: Endpoint) async throws -> Data {
        let urlRequest = try await endpoint.urlRequest()

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch {
            throw NetworkError.network(error)
        }

        try await validate(data: data, response: response)

        return data
    }
}

extension APIClient {
    private func validate(data: Data, response: URLResponse) async throws {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1

        if (200...299).contains(statusCode) {
            return
        }

        let statusResponse = try? decoder.decode(StatusResponse.self, from: data)
        let message = statusResponse?.statusMessage

        throw NetworkError(statusCode: statusCode, message: message)
    }
}
