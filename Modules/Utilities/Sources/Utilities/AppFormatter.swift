//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 24.01.2022.
//

import Foundation



public class AppFormatter {
    private let humidityEmoji = ["☀️","🌤","⛅️","🌥","☁️","🌦","🌧","⛈","🌩","🌨"]
    public init() { }
    
    public func weekday(_ date: Date) -> String {
        return DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: date)-1].capitalizingFirstLetter()
    }
    
    public func dateMediumFormat(_ from: Date) -> String {
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = "dd. MMM YYYY"
        return dateFormtter.string(from: from)
    }
    
    public func temperatureFormat(_ from: Double) -> String {
        return String(format: "%.0fºC", from)
    }
    
    public func feelsLikeFormat(_ from: Double) -> String {
        return "Feels like " + self.temperatureFormat(from)
    }
    
    public func formatHumidity(_ from: Int) -> String {
        return String("\(getEmojiFor(humidity: from)) \(from) %")
    }
    
    public func getEmojiFor(humidity: Int) -> String {
        if humidityEmoji.indices.contains(humidity/10) {
            return humidityEmoji[Int(humidity/10)]
        }
        return ""
    }
}
