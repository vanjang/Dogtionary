//
//  AccessibilityIds.swift
//  Dogtionary
//
//  Created by myung hoon on 11/02/2024.
//

import Foundation

/// Identifiers for UI Testing
public struct AccessibilityIdentifiers {
    public struct BreedList {
        public static let tableViewViewId = "\(BreedList.self).tableViewViewId"
        public static let searchTextFieldId = "\(BreedList.self).searchTextFieldId"
    }
    
    public struct BreedDetail {
        public static let collectionViewId = "\(BreedDetail.self).collectionViewId"
        public static let cellId = "\(BreedDetail.self).cellId"
    }
    
    public struct PhotoView {
        public static let rootViewId = "\(PhotoView.self).rootViewId"
        public static let closeButtonId = "\(PhotoView.self).closeButtonId"
    }
}
