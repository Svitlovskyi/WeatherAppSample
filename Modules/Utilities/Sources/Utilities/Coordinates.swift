//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 25.01.2022.
//

import Foundation


public struct Coordinates: Equatable, Codable {
    public let lat: Double
    public let long: Double
    
    public init(_ lat: Double, _ long: Double) {
        self.lat = lat
        self.long = long
    }
}
