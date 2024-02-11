//
//  MockNetworkService.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import Foundation
import Combine
@testable import Dogtionary

struct MockNetworkService: NetworkServiceType {
    var responseData: Data?
    var responseError: Error?

    init(responseData: Data? = nil, responseError: Error? = nil) {
        self.responseData = responseData
        self.responseError = responseError
    }

    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        if let responseError = responseError {
            return Fail(error: responseError).eraseToAnyPublisher()
        }
        
        guard let responseData = responseData else {
            return Fail(error: TestError.test).eraseToAnyPublisher()
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: responseData)
            return Just(decodedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

enum TestError: Error {
    case test
}
