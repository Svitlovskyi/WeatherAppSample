//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation
import Utilities



enum NetworkResponse: String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}


public struct NetworkWeatherManager {
    static let environment : NetworkEnvironment = .production
    static let APIKey = ""
    let router = Router<WeatherAPI>()
    
    public init() { }
    
    public func getWeather(coordinates: Coordinates,
                    completion: @escaping (_ weather: WeatherResponse?, _ error: String?) -> ()) {
        router.request(.weather(coordinates: coordinates),
                       completion: { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                if let result = self.handleNetworkResponse(response) {
                    completion(nil, result.localizedDescription)
                }
                
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                
                do {
                   let apiResponse = try JSONDecoder().decode(WeatherResponse.self, from: responseData)
                    completion(apiResponse,nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            }
        })
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Error? {
        switch response.statusCode {
        case 200...299: return nil
        case 401...500: return NetworkResponse.authenticationError
        case 501...599: return NetworkResponse.badRequest
        case 600: return NetworkResponse.outdated
        default: return NetworkResponse.failed
        }
    }
}
