//
//  SearchEndpointTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 03/04/2024.
//

@testable import ImageQuest
import XCTest

class SearchEndpointTests: XCTestCase {
    let baseURL = Constants.unsplashBaseURL
    let clientId = Constants.clientId
    let query = "query"
    var parameters = [String: Any]()
    
    func testSearchPhotos() {
        let endpoint = SearchEndpoint.photos(query: query)
        
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.query] = query
        
        XCTAssertEqual(endpoint.baseURL, baseURL)
        XCTAssertEqual(endpoint.path, "search/photos")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertTrue(NSDictionary(dictionary: endpoint.queryParameters).isEqual(to: parameters))
    }
}
