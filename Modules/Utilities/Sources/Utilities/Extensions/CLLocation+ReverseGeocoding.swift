//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import CoreLocation

public extension CLLocation {
    func geocode(completion: @escaping CLGeocodeCompletionHandler) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(self, completionHandler: completion)
    }
}

public extension CLLocationCoordinate2D {
    func geocode(completion: @escaping CLGeocodeCompletionHandler) {
        let geocoder = CLGeocoder()
        let clLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        geocoder.reverseGeocodeLocation(clLocation, completionHandler: completion)
    }}
