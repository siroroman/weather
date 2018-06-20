//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class WeatherData: Object, Unboxable {

    @objc dynamic var updated = Date()
    @objc dynamic var id = 0
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var name: String = ""
    @objc dynamic var temperature: Double = 0
    @objc dynamic var weatherID: Int = 0
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var visibility: Int = 0
    @objc dynamic var windSpeed: Double = 0
    @objc dynamic var sunrise: Int = 0
    @objc dynamic var sunset: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }

    required  convenience init(unboxer: Unboxer) throws {
        self.init()
        
        self.updated = Date()
        self.id = try unboxer.unbox(key: "id")
        self.latitude = try unboxer.unbox(keyPath: "coord.lat")
        self.longitude = try unboxer.unbox(keyPath: "coord.lon")
        self.name = try unboxer.unbox(key: "name")
        self.temperature = try unboxer.unbox(keyPath: "main.temp")
        self.weatherID = try unboxer.unbox(keyPath: "weather.0.id")
        self.weatherDescription = try unboxer.unbox(keyPath: "weather.0.description")
        self.pressure = try unboxer.unbox(keyPath: "main.pressure")
        self.humidity = try unboxer.unbox(keyPath: "main.humidity")
        self.visibility = try unboxer.unbox(key: "visibility")
        self.windSpeed = try unboxer.unbox(keyPath: "wind.speed")
        self.sunrise = try unboxer.unbox(keyPath: "sys.sunrise")
        self.sunset = try unboxer.unbox(keyPath: "sys.sunset")
    }

}
