//
//  CurrentWeatherWebService.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import CoreLocation
import Foundation
import Alamofire

class WeatherWebService {

    func loadData(for coordinate: CLLocationCoordinate2D, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        Alamofire
            .request(url(coordinate: coordinate))
            .responseData {response in completion(response.data, response.error)}
    }

    private func url(coordinate: CLLocationCoordinate2D) -> String {
        let baseURL = "http://api.openweathermap.org"
        let appID = "33529d0203a6eba27e18e70e501a02c3"
        return "\(baseURL)/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&APPID=\(appID)&units=metric&lang=cz"
    }
}
