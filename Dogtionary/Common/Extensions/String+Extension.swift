//
//  String+Extension.swift
//  Dogtionary
//
//  Created by myung hoon on 09/02/2024.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
