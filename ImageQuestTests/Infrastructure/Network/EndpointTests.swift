//
//  EndpointTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 03/04/2024.
//

@testable import ImageQuest
import XCTest

class EndpointTests: XCTestCase {
    func testRequestWithInvalidUrl() async throws {
        let expectedError = NSError(domain: NSURLErrorDomain, code: URLError.badURL.rawValue)
        
        let endpoint = Endpoint(baseURL: "/error", path: "path", method: .get)
        
        do {
            _ = try await endpoint.urlRequest()
        } catch let error as NetworkError {
            switch error {
            case .network(let error as NSError):
                XCTAssertEqual(error.code, expectedError.code)
                return
            default:
                break
            }
        }
    }
    
    func testRequestWithValidUrl() async throws {
        let endpoint = Endpoint(baseURL: "https://test.com", path: "path", method: .get)
        let request = try await endpoint.urlRequest()
        XCTAssertEqual(request.url, URL(string: "https://test.com/path"))
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testRequestWithValidUrlEndingWithForwardSlash() async throws {
        let endpoint = Endpoint(baseURL: "https://test.com/", path: "path", method: .get)
        let request = try await endpoint.urlRequest()
        XCTAssertEqual(request.url, URL(string: "https://test.com/path"))
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testRequestWithValidUrlAndQueryParameters() async throws {
        var parameters = [String: Any]()
        parameters["user"] = "John"
        let endpoint = Endpoint(
            baseURL: "https://test.com/",
            path: "path",
            method: .get,
            queryParameters: parameters
        )
        let request = try await endpoint.urlRequest()
        XCTAssertEqual(request.url, URL(string: "https://test.com/path?user=John"))
        XCTAssertEqual(request.httpMethod, "GET")
    }
}
