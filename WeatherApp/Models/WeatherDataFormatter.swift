//
//  WeatherDataFormatter.swift
//  WeatherApp
//
//  Created by Roman Siro on 20.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation

class WeatherDataFormatter {

    let data: WeatherData?

    private let unavailableText = "N/A"

    init(data: WeatherData?) {
        self.data = data
    }

    func formatedDescription() -> String {
        guard let desc = data?.weatherDescription else {return unavailableText}
        return desc
    }

    func formatedTime() -> String {
        guard let updated = data?.updated else {return unavailableText}

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current

        return dateFormatter.string(from: updated)
    }
    
    func formatedTemperature() -> String {
        guard let temperature = data?.temperature else {return unavailableText}
        return String(format: "%2.f°C", temperature)
    }

    func iconName() -> String{
        guard let id = data?.weatherID else {return ""}
        return WeatherIconProvider.icon(for: id)?.rawValue ?? ""
    }

    func formatedWindSpeed() -> String {
        guard let windSpeed = data?.windSpeed else {return unavailableText}
        return String(format: "%2.f m/s", windSpeed)
    }

    func formatedPressure() -> String {
        guard let pressure = data?.pressure else {return unavailableText}
        return String(format: "%0.d hPa", pressure)
    }

    func formatedHumidity() -> String {
        guard let humidity = data?.humidity else {return unavailableText}
        return String(format: "%0.d", humidity) + "%"
    }

    func formatedVisibility() -> String {
        guard let visibility = data?.visibility  else {return unavailableText}
        return String(format: "%0.d km", visibility / 1000)
    }

    func formatedSunrise() -> String {
        guard let sunrise = data?.sunrise  else {return unavailableText}
        return formatUnixTime(timeInterval: Double(sunrise))
    }

    func formatedSunset() -> String {
        guard let sunset = data?.sunset  else {return unavailableText}
        return formatUnixTime(timeInterval: Double(sunset))
    }

    private func formatUnixTime(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current

        return dateFormatter.string(from: date)
    }
    
}
