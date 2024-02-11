//
//  MockData.swift
//  DogtionaryTests
//
//  Created by myung hoon on 11/02/2024.
//

import Foundation
import XCTest
@testable import Dogtionary

struct MockData {
    static var allBreedsJsonData: Data {
        let allBreedsUrl = Bundle(for: NetworkServiceTests.self).url(forResource: "mockBreeds", withExtension: "json")
        guard let resourceUrl = allBreedsUrl, let data = try? Data(contentsOf: resourceUrl) else {
            XCTFail("Failed to create data object.")
            return Data()
        }
        return data
    }
    
    static var imageUrlsJsonData: Data {
        let imageUrlsUrl = Bundle(for: NetworkServiceTests.self).url(forResource: "mockUrlStrings", withExtension: "json")
        guard let resourceUrl = imageUrlsUrl, let data = try? Data(contentsOf: resourceUrl) else {
            XCTFail("Failed to create data object.")
            return Data()
        }
        return data
    }
}
