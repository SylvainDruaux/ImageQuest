//
//  PhotosEndpointTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 03/04/2024.
//

@testable import ImageQuest
import XCTest

class PhotosEndpointTests: XCTestCase {
    let baseURL = Constants.unsplashBaseURL
    let clientId = Constants.clientId
    let perPage = 30
    let orderBy = "latest"
    var parameters = [String: Any]()
    
    func testLatest() {
        let endpoint = PhotosEndpoint.latest(perPage: perPage)
        
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.perPage] = perPage
        parameters[QueryItemName.orderBy] = orderBy
        
        XCTAssertEqual(endpoint.baseURL, baseURL)
        XCTAssertEqual(endpoint.path, "photos")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertTrue(NSDictionary(dictionary: endpoint.queryParameters).isEqual(to: parameters))
    }
}
