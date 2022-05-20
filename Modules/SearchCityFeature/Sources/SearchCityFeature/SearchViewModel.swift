//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import MapKit
import Combine
import WeatherDetailFeature
import NetworkLayer
import Utilities


internal typealias CellModel = (leftItem: String, rightItem: String, coordinates: CLLocationCoordinate2D)

internal class SearchViewModel {
    @Published private(set) var results = [CellModel]()
    private(set) var error = PassthroughSubject<String, Never>()
    let searchRequest: MKLocalSearch.Request = {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.resultTypes = .address
        return searchRequest
    }()

	internal func updateQueryFragmentWith(query: String) {
        searchRequest.naturalLanguageQuery = query
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: { response, error in
            if let error = error {
                //TODO: Create custom errors
                self.error.send(error.localizedDescription)
                return
            }
            guard let response = response else { return }
            self.completerUpdateSearchResult(response: response)
        })
    }
    
    internal func buildDetailView(for index: Int) -> WeatherDetailViewController {
        let result = results[index]
        //TODO: Btw its better to move it to dependency injector, but not today :)
        let detailViewModel = WeatherDetailViewModel(
            coordinates: Coordinates(result.coordinates.latitude, result.coordinates.longitude),
            cityName: result.leftItem,
            countryName: result.rightItem)
        let detalView = WeatherDetailViewController()
        detalView.viewModel = detailViewModel
        return detalView
    }
    
    internal func completerUpdateSearchResult(response: MKLocalSearch.Response) {
        results = response.mapItems.compactMap(parseSearchResult(item:))
    }
    
    internal func parseSearchResult(item: MKMapItem) -> CellModel? {
        return CellModel(item.placemark.name ?? "",
                         item.placemark.country ?? "",
                         item.placemark.coordinate)
    }
}
