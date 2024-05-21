//
//  NetworkErrorTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 03/04/2024.
//

@testable import ImageQuest
import XCTest

class NetworkErrorTests: XCTestCase {
    func testNetwork() {
        let nsError = NSError(domain: "test", code: -1005)
        
        let networkError = NetworkError.network(nsError)
        
        switch networkError {
        case .network(let error):
            XCTAssertTrue(error.isOtherConnectionError)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testBadRequest() {
        let statusCode = 400
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .badRequest(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }

    func testUnauthorised() {
        let statusCode = 401
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .unauthorised(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testForbidden() {
        let statusCode = 403
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .forbidden(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testNotFound() {
        let statusCode = 404
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .notFound(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testTooManyRequests() {
        let statusCode = 429
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .tooManyRequests(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testInternalServerError() {
        let statusCode = 500
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .internalServerError(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }

    func testNotImplemented() {
        let statusCode = 501
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .notImplemented(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testBadGateway() {
        let statusCode = 502
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .badGateway(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }

    func testServiceUnavailable() {
        let statusCode = 503
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .serviceUnavailable(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }

    func testGatewayTimeout() {
        let statusCode = 504
        let expectedMessage = "Some error message"
        
        let networkError = NetworkError(statusCode: statusCode, message: expectedMessage)
        
        switch networkError {
        case .gatewayTimeout(let message):
            XCTAssertEqual(message, expectedMessage)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testDecode() {
        let nsError = NSError(domain: "test", code: 10)
        
        let networkError = NetworkError.decode(nsError)
        
        switch networkError {
        case .decode:
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
    
    func testUnknown() {
        let statusCode = 999
        
        let networkError = NetworkError(statusCode: statusCode, message: nil)
        
        switch networkError {
        case .unknown:
            XCTAssertTrue(true)
            XCTAssertNotNil(networkError.localizedDescription)
            
        default:
            XCTFail("Error does not match")
        }
    }
}
