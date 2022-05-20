//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import Foundation
import MapKit
import Utilities

protocol WeatherMapPresetnerProtocol: BaseViewPresenter<WeatherMapViewController> {
    func configureView()
    func add(coordinate: CLLocationCoordinate2D,
             title: String,
             subtitle: String)
    func zoomTo(coordinate: CLLocationCoordinate2D)
}

internal class WeatherMapPresenter: BaseViewPresenter<WeatherMapViewController>, WeatherMapPresetnerProtocol {
    func zoomTo(coordinate: CLLocationCoordinate2D) {
        let viewRegion = MKCoordinateRegion(center: coordinate,
                                            latitudinalMeters: 25000,
                                            longitudinalMeters: 25000)
        viewController?.mapViewWithControls.mapView.setRegion(viewRegion, animated: true)
    }
    
    func configureView() {
        viewController?.configureView()
    }
    
    func add(coordinate: CLLocationCoordinate2D,
             title: String,
             subtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        viewController?.mapViewWithControls.mapView.addAnnotation(annotation)
    }
}
