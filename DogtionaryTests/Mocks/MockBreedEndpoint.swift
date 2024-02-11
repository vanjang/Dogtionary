//
//  MockBreedEndpoint.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import Foundation
@testable import Dogtionary

struct MockBreedEndpoint: Endpoint {
    let baseURL: String
    let path: String = ""
    let method: Dogtionary.HTTPMethod = .get
    var parameters: [URLQueryItem]? = nil
    var headers: [String : String]? = nil
}
