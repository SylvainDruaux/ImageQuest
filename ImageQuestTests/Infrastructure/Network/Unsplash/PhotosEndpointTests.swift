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
    let orderBy: OrderBy = .latest
    let photoID = "KMn4VEeEPR8"
    var parameters = [String: Any]()
    
    func testList() {
        let endpoint = PhotosEndpoint.list(page: nil, perPage: perPage, orderBy: orderBy)
        
        parameters[QueryItemName.clientId] = clientId
        parameters[QueryItemName.perPage] = perPage
        parameters[QueryItemName.orderBy] = orderBy.rawValue
        
        XCTAssertEqual(endpoint.baseURL, baseURL)
        XCTAssertEqual(endpoint.path, "photos")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertTrue(NSDictionary(dictionary: endpoint.queryParameters).isEqual(to: parameters))
    }
    
    func testGet() {
        let endpoint = PhotosEndpoint.get(photoID: photoID)
        
        parameters[QueryItemName.clientId] = clientId
        
        XCTAssertEqual(endpoint.baseURL, baseURL)
        XCTAssertEqual(endpoint.path, "photos/\(photoID)")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertTrue(NSDictionary(dictionary: endpoint.queryParameters).isEqual(to: parameters))
    }
}
