//
//  FavouriteCitiesRepository.swift
//  
//
//  Created by Maksym Svitlovskyi on 25.01.2022.
//

import Foundation
import Utilities
import DatabaseLayer

public struct FavouriteCity: Equatable, Codable {
    public let cityName: String
    public let countryName: String
    public let coordinates: Coordinates
}

public class FavouriteCitiesRepository {
    lazy public var favourites: [FavouriteCity] = {
        return favouritesDatabase.getItems()
    }()
    public private(set) var favouritesDatabase = FavouritesDataBase<FavouriteCity>()
    
    public init() { }
    
    public func refresh() {
        favourites = favouritesDatabase.getItems()
    }
}


public extension Notification.Name {
    static let onFavouriteCityUpdate: Notification.Name = .init("onFavouriteCityUpdate")
}
