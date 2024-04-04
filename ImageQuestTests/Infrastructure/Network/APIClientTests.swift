//
//  APIClientTests.swift
//  ImageQuestTests
//
//  Created by Sylvain Druaux on 03/04/2024.
//

@testable import ImageQuest
import XCTest

class APIClientTests: XCTestCase {
    var apiClient: APIClient!
    var endpoint: Endpoint!
    var urlSession: URLSession!
    var decoder: JSONDecoderProtocol!
    
    var headerParameters = [String: String]()
    var queryParameters = [String: Any]()
    var bodyParametersEncodable: Encodable!
    
    override func setUp() {
        super.setUp()
        
        // Default endpoint
        endpoint = Endpoint(
            baseURL: "https://some.domain.com",
            path: "path",
            method: .get
        )
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        urlSession = URLSession(configuration: configuration)
        decoder = JSONDecoder()
        apiClient = APIClient(urlSession: urlSession)
    }
    
    override func tearDown() {
        apiClient = nil
        URLProtocolMock.reset()
        super.tearDown()
    }
    
    func testRequestFailsThrowsNetworkError() async throws {
        let expectedError = NSError(domain: NSURLErrorDomain, code: URLError.badServerResponse.rawValue)
        URLProtocolMock.failError = expectedError
        
        do {
            _ = try await apiClient.request(endpoint: endpoint)
        } catch let error as NetworkError {
            switch error {
            case .network(let error as NSError):
                XCTAssertEqual(error.code, expectedError.code)
                return
            default:
                break
            }
        }
        
        XCTFail("Expected error to be thrown")
    }
    
    func testResponseStatusCodeIs401ReturnsUnauthorisedError() async throws {
        URLProtocolMock.responseStatusCode = 401
        
        do {
            _ = try await apiClient.request(endpoint: endpoint)
        } catch let error as NetworkError {
            switch error {
            case .unauthorised:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }
        
        XCTFail("Expected unauthorised error to be thrown")
    }
    
    func testResponseStatusCodeIs404ReturnsNotFoundError() async throws {
        URLProtocolMock.responseStatusCode = 404
        
        do {
            _ = try await apiClient.request(endpoint: endpoint)
        } catch let error as NetworkError {
            switch error {
            case .notFound:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }
        
        XCTFail("Expected not found error to be thrown")
    }

    func testResponseHasValidDataReturnsDecodedObject() async throws {
        let expectedResult = MockObject()
        URLProtocolMock.data = expectedResult.data
        
        let result: MockObject = try await apiClient.request(endpoint: endpoint)
        
        XCTAssertEqual(result, expectedResult)
    }

    func testResponseHasValidDataReturnsError() async throws {
        // GIVEN
        let decoderMock = JSONDecoderProtocolMock()
        apiClient = APIClient(urlSession: urlSession, decoder: decoderMock)
        let expectedResult = MockObject()
        URLProtocolMock.data = expectedResult.data
        let errorMock = NSError(domain: "domain", code: 1000, userInfo: ["userInfo": 10])
        let expectedError = NetworkError.decode(errorMock)
        decoderMock.decodeFromThrowableError = expectedError
        
        // WHEN
        do {
            let _: MockObject = try await apiClient.request(endpoint: endpoint)
        } catch let error as NetworkError {
            switch error {
            case .decode(_ as NSError):
                // THEN
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }
        
        XCTFail("Expected not found error to be thrown")
    }
}

extension APIClientTests {
    private struct MockObject: Codable, Equatable {
        let id: UUID
        
        var data: Data {
            // swiftlint:disable force_try
            try! JSONEncoder().encode(self)
            // swiftlint:enable force_try
        }
        
        init(id: UUID = .init()) {
            self.id = id
        }
    }
}
