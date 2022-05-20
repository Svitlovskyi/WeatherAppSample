//
//  MovieEndPoint.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation
import Utilities


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum WeatherAPI {
    case weather(coordinates: Coordinates)
}

extension WeatherAPI: EndPointType {
    var environmentBaseURL : String {
        switch NetworkWeatherManager.environment {
        case .production: return "https://api.openweathermap.org/data/2.5/"
        case .qa: return "https://api.openweathermap.org/data/2.5/"
        case .staging: return "https://api.openweathermap.org/data/2.5/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .weather(coordinates: _):
            return "onecall"
  
        }
    }
    
    var apiKey: String {
        return "396e80f11f401ec1966bf3fcbebb07a3"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .weather(coordinates: let coordinates):
            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: [
                    "lat": coordinates.lat,
                    "lon": coordinates.long,
                    "appid": apiKey,
                    "exclude": "minutely, hourly",
                    "units": "metric"
                ]
            )
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


