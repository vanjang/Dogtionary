//
//  URLCache+Extension.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation

extension URLCache {
    static func configSharedCache(memory: Int, disk: Int) {
        let cache = URLCache(memoryCapacity: memory, diskCapacity: disk, diskPath: "apodApiCache")
        URLCache.shared = cache
    }
}
