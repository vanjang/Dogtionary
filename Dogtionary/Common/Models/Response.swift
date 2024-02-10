//
//  Response.swift
//  Dogtionary
//
//  Created by myung hoon on 10/02/2024.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let message: T
}
