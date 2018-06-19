//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {

    var currentLocationChanged: ((CLLocationCoordinate2D) -> Void)?

    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let currentLocationChanged = self.currentLocationChanged {
                print(location.coordinate)
                currentLocationChanged(location.coordinate)
            }
        }
    }
    
}
