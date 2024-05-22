//
//  URLProtocolMock.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    static var data: Data?
    static var failError: Error?
    static var responseStatusCode: Int = 200
    
    override class func canInit(with _: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let failError = Self.failError {
            client?.urlProtocol(self, didFailWithError: failError)
            return
        }
        
        guard let url = request.url else {
            return
        }
        
        if let data = Self.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        let response = HTTPURLResponse(
            url: url,
            statusCode: Self.responseStatusCode,
            httpVersion: "2.0",
            headerFields: nil
        )!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
    
    static func reset() {
        data = nil
        failError = nil
        responseStatusCode = 200
    }
}
