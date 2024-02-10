//
//  Array+Extension.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation

extension Array where Element: Any {
    func randomElements(count: Int) -> [Element] {
        guard !self.isEmpty else { return [] }
        
        if count >= self.count {
            return self
        }
        
        var randomElements: [Element] = []
        var indices = Set<Int>()
        
        while randomElements.count < count {
            let randomIndex = Int.random(in: 0..<self.count)
            if !indices.contains(randomIndex) {
                indices.insert(randomIndex)
                randomElements.append(self[randomIndex])
            }
        }
        
        return randomElements
    }
}
