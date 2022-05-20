//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import Foundation
import Combine
import UIComponents
import Utilities
import BusinessLogicLayer
import NetworkLayer
import UIKit

internal class DetailUiModel {
    @Published var header: TripleLineHeaderModel = TripleLineHeaderModel("", "", "")
    @Published var items: [EqualSpacingThreeTextCellModel] = []
    @Published var footer: NSAttributedString = NSAttributedString(string: "")
    
    init() {    }
}


public class WeatherDetailViewModel {
    private lazy var formatter = AppFormatter()
    private(set) var repository: CityWeatherRepository
    
    private(set) var cityName: String
    private(set) var currentDate: String = {
        return AppFormatter().dateMediumFormat(Date())
    }()
    
    private var cancellable: AnyCancellable?
    @Published var detailUiModel: DetailUiModel = DetailUiModel()
    
    public init(coordinates: Coordinates=Coordinates(48.716385, 21.261074),
                cityName: String,
                countryName: String) {
        self.cityName = cityName
        self.repository = CityWeatherRepository(
            coordinates: coordinates,
            cityName: cityName,
            countryName: countryName)
    }
    
    internal func setupBinding() {
        repository.updateWeather()
        
        cancellable = self.repository.$weatherResponse
            .combineLatest(repository.isFavourite)
            .sink(receiveValue: { resp, isFavourite in
                DispatchQueue.main.async {
                    guard let response = resp else { return }
                    self.detailUiModel.items = self.getItems(from: response)
                    self.detailUiModel.header = self.getHeader(from: response)
                    self.detailUiModel.footer = self.getFooter(isFavourite: isFavourite)
                }
            })
    }
    
    public func addRemoveFromFavourie() {
        repository.addOrRemoveToFavourites()
    }
    
    //MARK: - Move to DTO Converter latter.
    private func getItems(from: WeatherResponse) -> [EqualSpacingThreeTextCellModel] {
        var dailyWeather = from.daily
        dailyWeather.removeFirst()
        let items: [EqualSpacingThreeTextCellModel] = dailyWeather.compactMap(getItem(daily:))
    	return items
    }
    
    private func getItem(daily: Daily) -> EqualSpacingThreeTextCellModel? {
        let date = Date(timeIntervalSince1970: TimeInterval(daily.dt))
        
        return EqualSpacingThreeTextCellModel(
            formatter.weekday(date),
            formatter.formatHumidity(daily.humidity),
            formatter.temperatureFormat(daily.temp.day)
        )
    }
    
    private func getFooter(isFavourite: Bool) -> NSAttributedString {
        let text = isFavourite ? LocalizationKeys.removeFromFavourites.localized(bundle: .module) : LocalizationKeys.addToFavourites.localized(bundle: .module)
            return NSMutableAttributedString(string: text, attributes: [.foregroundColor: UIColor.appRed, .font: UIFont.headlineSemibold])
    }
    
    private func getHeader(from: WeatherResponse) -> TripleLineHeaderModel {
        return TripleLineHeaderModel(
            formatter.temperatureFormat(from.current.temp),
            from.current.weather.first?.description.capitalizingFirstLetter() ?? "",
            formatter.feelsLikeFormat(from.current.feels_like)
        )
    }
}
