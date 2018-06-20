//
//  MapVM.swift
//  WeatherApp
//
//  Created by Roman Siro on 20.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation
import CoreLocation

class MapVM {

    private let coordinate: CLLocationCoordinate2D

    var mapCenterCoordinate: CLLocationCoordinate2D {
        return coordinate
    }

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
}
