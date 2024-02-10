//
//  BreedEndpoint.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation

struct BreedEndpoint: Endpoint {
    var baseURL: String { "https://dog.ceo/api/" }
    var path: String
    let method: HTTPMethod
    let parameters: [URLQueryItem]?
    let headers: [String: String]?
}
