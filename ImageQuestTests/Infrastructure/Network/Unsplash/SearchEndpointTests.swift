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
    let page = 2
    let perPage = 20
    let orderBy: OrderBy = .relevant
    var parameters = [String: Any]()
    
    func testSearchPhotos() {
        let endpoint = SearchEndpoint.photos(query: query, page: nil, perPage: nil, orderBy: nil)
        
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.query] = query
        
        XCTAssertEqual(endpoint.baseURL, baseURL)
        XCTAssertEqual(endpoint.path, "search/photos")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertTrue(NSDictionary(dictionary: endpoint.queryParameters).isEqual(to: parameters))
    }
    
    func testSearchPhotosWithAllParameters() {
        let endpoint = SearchEndpoint.photos(query: query, page: page, perPage: perPage, orderBy: orderBy)
        
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.query] = query
        parameters[QueryItemName.page] = page
        parameters[QueryItemName.perPage] = perPage
        parameters[QueryItemName.orderBy] = orderBy.rawValue
        
        XCTAssertEqual(endpoint.baseURL, baseURL)
        XCTAssertEqual(endpoint.path, "search/photos")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertTrue(NSDictionary(dictionary: endpoint.queryParameters).isEqual(to: parameters))
    }
}
