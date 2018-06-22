//
//  WeatherVM.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherItem {
    let place: String
    let time: String
    let iconName: String
    let weatherDescription: String
    let temperature: String
    let detailItems: [WeatherDetailItem]
}

class WeatherVM {

    var currentWeather: WeatherItem {
        return createCurrentWeather()
    }

    var currentCoordinate: CLLocationCoordinate2D?

    var didStartUpdatingData: (() -> ())?
    var didUpdateData: (() -> ())?

    private var data: WeatherData?

    private let locationManager = LocationManager()

    private let debouncer = Debouncer(timeInterval: 0.5)

    init() {
        locationManager.currentLocationChanged = currentLocationChanged
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appBecomeActive), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    func reloadData() {
        getLocation()
    }

    @objc func appBecomeActive() {
        reloadData()
    }

    private func getLocation() {
        locationManager.requestAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func currentLocationChanged(coordinate: CLLocationCoordinate2D) {
        currentCoordinate = coordinate
        locationManager.stopUpdatingLocation()
        debouncer.handler = { self.reloadData(for: coordinate)}
        debouncer.renewInterval()
    }

    private func reloadData(for coordinate: CLLocationCoordinate2D ) {
        self.didStartUpdatingData?()
        let dataProvider = WeatherDataProvider(coordinate: coordinate)
        dataProvider.data {data , error in
            self.data = data
            self.didUpdateData?()
        }
    }

    private func createCurrentWeather() -> WeatherItem {
        let formatter = WeatherDataFormatter(data: data)

        let place = data?.name ?? ""
        let time = formatter.formatedTime()
        let iconName = formatter.iconName()
        let weatherDescription = formatter.formatedDescription()
        let temperature = formatter.formatedTemperature()
        let detailItems = detailItemsList()

        return WeatherItem(place: place, time: time, iconName: iconName,
                           weatherDescription: weatherDescription,
                           temperature: temperature, detailItems: detailItems)
    }

    private func detailItemsList() -> [WeatherDetailItem] {
        let formatter = WeatherDataFormatter(data: data)

        let windItem = WeatherDetailItem(imageName: "wind", descriptionText: "Wind", valueText: formatter.formatedWindSpeed())
        let pressureItem = WeatherDetailItem(imageName: "barometer", descriptionText: "Pressure", valueText: formatter.formatedPressure())
        let humidityItem = WeatherDetailItem(imageName: "humidity", descriptionText: "Humidity", valueText: formatter.formatedHumidity())
        let visibilityItem = WeatherDetailItem(imageName: "visibility", descriptionText: "Visibility", valueText: formatter.formatedVisibility())
        let sunriseItem = WeatherDetailItem(imageName: "sunrise", descriptionText: "Sunrise", valueText: formatter.formatedSunrise())
        let sunsetItem = WeatherDetailItem(imageName: "sunset", descriptionText: "Sunset", valueText: formatter.formatedSunset())

        return [windItem, pressureItem, humidityItem, visibilityItem, sunriseItem, sunsetItem]
    }

}
