//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import Foundation


public class WeatherMapConfigurator {
    public init() { }
    
    public func configure(viewController: WeatherMapViewController) {
        let presenter = WeatherMapPresenter(viewController: viewController)
        let interactor = WeatherMapInteractor(presenter: presenter)
        viewController.interactor = interactor
    }
}
