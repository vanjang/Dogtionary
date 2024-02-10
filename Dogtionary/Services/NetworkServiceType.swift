//
//  NetworkServiceType.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation
import Combine

/// Protocol defining the requirements for a network service.
protocol NetworkServiceType {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
}
