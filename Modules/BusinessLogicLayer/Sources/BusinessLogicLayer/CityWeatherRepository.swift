//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 25.01.2022.
//
import NetworkLayer
import DatabaseLayer
import Combine
import Utilities
import Foundation


public class CityWeatherRepository {
    private(set) var networkManager: NetworkWeatherManager = NetworkWeatherManager()
    private(set) var favouritesDatabase = FavouritesDataBase<FavouriteCity>()
    //Its better to use not network models, DTO instead, but im already overhead this task, btw
    @Published public private(set) var weatherResponse: WeatherResponse?
    public private(set) var isFavourite = PassthroughSubject<Bool, Never>()
    //To not depend on coordinates in request answer its better to use another variable, i think, what you thing? :>
    private let cityName: String
    private let countryName: String
    private var coordinates: Coordinates
    public init(coordinates: Coordinates, cityName: String, countryName: String) {
        self.cityName = cityName
        self.countryName = countryName
        self.coordinates = coordinates
    }
    
    public func updateWeather() {
        networkManager.getWeather(coordinates: coordinates,
                                  completion: { weatherResponse, error in
            if let error = error {
                print(error)
                return
            }
            guard let weatherResponse = weatherResponse else {
                return
            }
            
            self.weatherResponse = weatherResponse
            self.coordinates = Coordinates(weatherResponse.lat, weatherResponse.lon)
            self.updateIsFavourite()
        })
    }
    
    public func addOrRemoveToFavourites() {
        let favouriteModel = buildFavouriteModel()
        do {
            if !favouritesDatabase.isFavourite(favouriteModel) {
                try favouritesDatabase.add(favouriteModel)
            } else {
                try favouritesDatabase.remove(favouriteModel)
            }
            NotificationCenter.default.post(name: .onFavouriteCityUpdate, object: nil)
        } catch {
            print(error.localizedDescription)
        }
        updateIsFavourite()
    }
    
    private func updateIsFavourite() {
        isFavourite.send(favouritesDatabase.isFavourite(buildFavouriteModel()))
    }
    
    private func buildFavouriteModel() -> FavouriteCity {
        return FavouriteCity(cityName: cityName,
                                           countryName: countryName,
                                           coordinates: coordinates)
    }
}


