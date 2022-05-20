//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import UIKit
import UIComponents
import MapKit
import WeatherDetailFeature
import Utilities

public class WeatherMapViewController: UIViewController, MKMapViewDelegate {
    var interactor: WeatherMapInteractorProtocol?
    
    lazy public  var mapViewWithControls: MapViewWithControls = {
        let mapViewWithControls = MapViewWithControls()
        return mapViewWithControls
    }()
    
    override public func loadView() {
        super.loadView()
        view = mapViewWithControls
        mapViewWithControls.mapView.delegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewDidLoad()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                             action: #selector(addPin(_:)))
        mapViewWithControls.mapView.addGestureRecognizer(gestureRecognizer)
        mapViewWithControls.button.addTarget(self,
                                             action: #selector(zoomToUserLocation(_:)),
                                             for: .touchDown)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    public func configureView() {
        mapViewWithControls.button.tintColor = .appPurple
        mapViewWithControls.mapView.showsUserLocation = true
    }
    
    @objc func addPin(_ sender: UITapGestureRecognizer) {
        let mapView = mapViewWithControls.mapView
        let location = sender.location(in: mapView)
        let coordinate = mapViewWithControls.mapView.convert(location, toCoordinateFrom: mapView)
        interactor?.addPin(in: coordinate)
    }
    
    @objc func zoomToUserLocation(_ sender: UIButton) {
        interactor?.zoomToCurrentLocation()
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        guard let cityName = annotation.title else { return }
        guard let countryName = annotation.subtitle else { return }
        
        if let cityName = cityName, let countryName = countryName {
            DispatchQueue.main.async {
                let weatherDetailView = WeatherDetailViewController()
                weatherDetailView.viewModel = WeatherDetailViewModel(
                    coordinates: Coordinates(annotation.coordinate.latitude,
                                             annotation.coordinate.longitude),
                    cityName: cityName,
                    countryName: countryName)
                mapView.deselectAnnotation(view.annotation, animated: true)
                self.navigationController?.pushViewController(weatherDetailView, animated: true)
            }
        }
    }
}
