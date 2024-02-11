//
//  NetworkServiceTests.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import XCTest
import Combine
@testable import Dogtionary

final class NetworkServiceTests: XCTestCase {
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }()
    
    private lazy var networkService = NetworkService(session: session)
    
    private let response = Response<[String: [String]]>(message: [:])
    
    private let url = Bundle(for: NetworkServiceTests.self).url(forResource: "mockBreeds", withExtension: "json")
    
    private lazy var mockJsonData: Data = {
        guard let resourceUrl = url, let data = try? Data(contentsOf: resourceUrl) else {
            XCTFail("Failed to create data object from string!")
            return Data()
        }
        return data
    }()
    
    private var endpoint: MockBreedEndpoint {
        MockBreedEndpoint(baseURL: url?.absoluteString ?? "")
    }
    
    private var cancellables: [AnyCancellable] = []

    override class func setUp() {
        URLProtocol.registerClass(URLProtocolMock.self)
    }
    
    func simulateRequest(endpint: MockBreedEndpoint) -> AnyPublisher<Result<[Breed], Error>, Never> {
       networkService.request(endpoint)
            .map { (response: Response<[String: [String]]>) -> Result<[Breed], Error> in
                var breeds: [Breed] = []
                response.message.forEach {
                    let breed = Breed(name: $0.key, subBreeds: $0.value)
                    breeds.append(breed)
                }
                return .success(breeds)
            }
            .catch { error -> AnyPublisher<Result<[Breed], Error>, Never> in .just(.failure(error)) }
            .eraseToAnyPublisher()
    }
    
    
    func testLoadFinishedSuccessfully() {
        // Given
        var result: Result<[Breed], Error>?
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.mockJsonData)
        }

        // When
        simulateRequest(endpint: endpoint)
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
        }).store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .success(let breeds) = result else {
            XCTFail()
            return
        }
        XCTAssertEqual(breeds.count, 20)
    }

    func testLoadFailedWithError() {
        // Given
        var result: Result<[Breed], Error>?
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // When
        simulateRequest(endpint: endpoint)
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
        }).store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
        guard case .failure(_) = result else {
            XCTFail()
            return
        }
    }

    func testLoadFailedWithJsonParsingError() {
        // Given
        var result: Result<[Breed], Error>?
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // When
        simulateRequest(endpint: endpoint)
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
        }).store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .failure(let error) = result, error is DecodingError else {
            XCTFail()
            return
        }
    }
}
