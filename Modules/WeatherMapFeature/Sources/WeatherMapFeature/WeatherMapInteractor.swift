//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import Foundation
import CoreLocation

protocol WeatherMapInteractorProtocol {
    func addPin(in location: CLLocationCoordinate2D)
    func zoomToCurrentLocation()
    func viewDidLoad()
}

internal class WeatherMapInteractor: WeatherMapInteractorProtocol {
    private var presenter: WeatherMapPresenter?
    private let locationManager = CLLocationManager()
    
    init(presenter: WeatherMapPresenter) {
        self.presenter = presenter
    }
	
    func viewDidLoad() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        presenter?.configureView()
    }
    
    func addPin(in location: CLLocationCoordinate2D) {
        location.geocode { landmarks, error in
            if let error = error {
                self.presenter?.alert(with: "Cant add pin to map", message: error.localizedDescription)
                return
            }
            guard let landmark = landmarks?.first,
                  let locality = landmark.locality, let country = landmark.country else {
                self.presenter?.alert(with: "Cant find pin")
                return
            }
            
            self.presenter?.add(coordinate: location,
                                title: locality,
                                subtitle: country)
        }
    }
    
    func zoomToCurrentLocation() {
        if let userLocation = locationManager.location?.coordinate {
            presenter?.zoomTo(coordinate: userLocation)
        }
    }
}
