// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

public struct WeatherResponse: Codable {
    public let lat: Double
    public let lon: Double
    public let timezone: String
    public let current: Current
    public var daily: [Daily]
}

public struct Current: Codable {
    public let dt: Int
    public let sunrise: Int
    public let sunset: Int
    public let temp: Double
    public let feels_like: Double
    public let pressure: Int
    public let humidity: Int
    public let dew_point: Double
    public let uvi: Double
    public let clouds: Int
    public let wind_speed: Double
    public let wind_deg: Int
    public let weather: [Weather]
}

public struct Weather: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

public struct Hourly: Codable {
    public let dt: Int
    public let temp: Double
    public let feels_like: Double
    public let pressure: Int
    public let humidity: Int
    public let dew_point: Double
    public let clouds: Int
    public let wind_speed: Double
    public let wind_deg: Int
    public let weather: [Weather]
}

public struct Daily: Codable {
    public let dt: Int
    public let sunrise: Int
    public let sunset: Int
    public let temp: Temperature
    public let feels_like: Feels_Like
    public let pressure: Int
    public let humidity: Int
    public let dew_point: Double
    public let wind_speed: Double
    public let wind_deg: Int
    public let weather: [Weather]
    public let clouds: Int
    public let uvi: Double
}

public struct Temperature: Codable {
    public let day: Double
    public let min: Double
    public let max: Double
    public let night: Double
    public let eve: Double
    public let morn: Double
}

public struct Feels_Like: Codable {
    public let day: Double
    public let night: Double
    public let eve: Double
    public let morn: Double
}
