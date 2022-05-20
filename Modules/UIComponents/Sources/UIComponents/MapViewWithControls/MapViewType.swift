//
//  File.swift
//  
//
//  Created by Maksym on 22/01/2022.
//

import Foundation
import Utilities

internal enum MapViewType: RawRepresentable, CaseIterable {
    typealias RawValue = String
    
    case standard
    case satellite
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case LocalizationKeys.mapViewStandard.localized(bundle: .module):
            self = .standard
        case LocalizationKeys.mapViewSattelite.localized(bundle: .module):
            self = .satellite
        default:
            return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .satellite:
            return LocalizationKeys.mapViewSattelite.localized(bundle: .module)
        case .standard:
            return LocalizationKeys.mapViewStandard.localized(bundle: .module)
            
        }
    }
}

